// open pcm file, compress, pass compressed file to global buffer, uncompress, and playback in 480ms intervals

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include "portaudio.h"
#include "lpcnet.h"

#define SAMPLE_RATE  (16000)
#define FRAMES_PER_BUFFER (0)
#define NUM_SECONDS     (2)
#define NUM_CHANNELS    (1)
#define PA_SAMPLE_TYPE  paInt16
typedef short SAMPLE;
#define SAMPLE_SILENCE  (0)
#define PRINTF_S_FORMAT "%d"

pthread_mutex_t mutex;
pthread_cond_t cond_new_wanted, cond_new_ready;
unsigned char* global_buffer;
int global_buffer_empty = 1;


typedef struct
{
    int          frameIndex;  /* Index into sample array. */
    int          maxFrameIndex;
    SAMPLE*      recordedSamples; // float recorded samples
}
paTestData;

PaStreamParameters  outputParameters;
PaStream*           stream;
PaError             err = paNoError;
paTestData          data;

int                 i;
int                 totalFrames;
int                 numSamples;
int                 numBytes;

static int playCallback( const void *inputBuffer, void *outputBuffer,
                         unsigned long framesPerBuffer,
                         const PaStreamCallbackTimeInfo* timeInfo,
                         PaStreamCallbackFlags statusFlags,
                         void *userData )
{
    paTestData* data = (paTestData*)userData;
    SAMPLE *rptr = &data->recordedSamples[data->frameIndex * NUM_CHANNELS];
    SAMPLE *wptr = (SAMPLE*)outputBuffer;
    unsigned int i;
    int finished;
    unsigned int framesLeft = data->maxFrameIndex - data->frameIndex;

    (void) inputBuffer; /* Prevent unused variable warnings. */
    (void) timeInfo;
    (void) statusFlags;
    (void) userData;

    if( framesLeft < framesPerBuffer )
    {
        /* final buffer... */
        for( i=0; i<framesLeft; i++ )
        {
            *wptr++ = *rptr++;  /* left */
            if( NUM_CHANNELS == 2 ) *wptr++ = *rptr++;  /* right */
        }
        for( ; i<framesPerBuffer; i++ )
        {
            *wptr++ = 0;  /* left */
            if( NUM_CHANNELS == 2 ) *wptr++ = 0;  /* right */
        }
        data->frameIndex += framesLeft;
        finished = paComplete;
    }
    else
    {
        for( i=0; i<framesPerBuffer; i++ )
        {
            *wptr++ = *rptr++;  /* left */
            if( NUM_CHANNELS == 2 ) *wptr++ = *rptr++;  /* right */
        }
        data->frameIndex += framesPerBuffer;
        finished = paContinue;
    }
    return finished;
}



void* upload_data(void* arg){
    // ready input file
    FILE *fin;
    fin = fopen("input.pcm", "rb");
    if (fin == NULL){
        perror("Error open input.pcm");
        // exit(-1);
    }
    // ready lpcnet
    LPCNetEncState *net = lpcnet_encoder_create();
    // 480ms coompressed = 96 bytes
    unsigned char compressed_buf_480ms[12 * LPCNET_COMPRESSED_SIZE];
    // 40ms compressed = 8 bytes
    unsigned char compressed_buf[LPCNET_COMPRESSED_SIZE];
    // uncompressed data, proper size for lpcnet_encode() to work
    SAMPLE pcm_buffer[sizeof(SAMPLE) * LPCNET_PACKET_SAMPLES];
    size_t ret;
    int i;
    
    while(1){
        
        pthread_mutex_lock(&mutex);

        while(!global_buffer_empty){
            pthread_cond_wait(&cond_new_wanted, &mutex);
        }

        for(i = 0; i < 12; i++){
            // fill pcm
            ret = fread(pcm_buffer, sizeof(SAMPLE), LPCNET_PACKET_SAMPLES, fin);
            if(feof(fin) || ret != LPCNET_PACKET_SAMPLES) break;
            lpcnet_encode(net, pcm_buffer, compressed_buf);
            memcpy(compressed_buf_480ms + i * LPCNET_COMPRESSED_SIZE, compressed_buf, LPCNET_COMPRESSED_SIZE);
        }

        global_buffer_empty = i - 12;
        memcpy(global_buffer, compressed_buf_480ms, i * LPCNET_COMPRESSED_SIZE);
        pthread_cond_signal(&cond_new_ready);
        pthread_mutex_unlock(&mutex);

        if(i!=12){
            printf("Producer out\n");
            break;
        }
        else{
            printf("Producer in action\n");
        }
    }

    fclose(fin);
    lpcnet_encoder_destroy(net);
    return 0;
}

void* fetch_data(void* arg){

    // FILE* fout = fopen("output.pcm","wb");
    
    LPCNetDecState *net = lpcnet_decoder_create();
    int j;

    unsigned char compressed_buf_480ms[12*LPCNET_COMPRESSED_SIZE];
    unsigned char compressed_buf[LPCNET_COMPRESSED_SIZE];
    SAMPLE pcm_buffer[sizeof(SAMPLE) * LPCNET_PACKET_SAMPLES];


    data.maxFrameIndex = totalFrames = numSamples = 7680;
    data.frameIndex = 0;
    numBytes = numSamples * sizeof(SAMPLE);
    data.recordedSamples = (SAMPLE*)malloc(numBytes);

    /* Prepare to playback recorded data.  -------------------------------------------- */
    err = Pa_Initialize();
    if( err != paNoError ){exit(-1);}
    
    outputParameters.device = Pa_GetDefaultOutputDevice(); /* default output device */
    if (outputParameters.device == paNoDevice) {
        fprintf(stderr,"Error: No default output device.\n");
        exit(-1);
    }
    outputParameters.channelCount = NUM_CHANNELS;
    outputParameters.sampleFormat =  PA_SAMPLE_TYPE;
    outputParameters.suggestedLatency = Pa_GetDeviceInfo( outputParameters.device )->defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = NULL;  

    while(1){
        
        data.frameIndex = 0;
        // halt until signal received
        // break if terminate signal received
        pthread_mutex_lock(&mutex);
        while(global_buffer_empty > 0){
            pthread_cond_wait(&cond_new_ready, &mutex);
        }

        memcpy(compressed_buf_480ms, global_buffer, (global_buffer_empty + 12) * LPCNET_COMPRESSED_SIZE);

        for(j = 0; j < global_buffer_empty + 12; j++){
            memcpy(compressed_buf, compressed_buf_480ms + i * LPCNET_COMPRESSED_SIZE, LPCNET_COMPRESSED_SIZE);
            lpcnet_decode(net, compressed_buf, pcm_buffer);
            memcpy(data.recordedSamples + i * LPCNET_PACKET_SAMPLES, pcm_buffer, LPCNET_PACKET_SAMPLES);
        }

        printf("\n=== Now playing back. ===\n"); fflush(stdout);
        err = Pa_OpenStream(
                &stream,
                NULL, /* no input */
                &outputParameters,
                SAMPLE_RATE,
                FRAMES_PER_BUFFER,
                paClipOff,
                playCallback,
                &data );
        if( err != paNoError ){exit(-1);};

        if( stream )
        {
            err = Pa_StartStream( stream );
            if( err != paNoError ){exit(-1);}

            printf("Waiting for playback to finish.\n"); fflush(stdout);

            while( ( err = Pa_IsStreamActive( stream ) ) == 1 ) Pa_Sleep(100);
            if( err < 0 ){exit(-1);}

            err = Pa_CloseStream( stream );
            if( err != paNoError ){exit(-1);}
        }


        pthread_cond_signal(&cond_new_wanted);
        pthread_mutex_unlock(&mutex);
        if(global_buffer_empty < 0){
            printf("Consumer out\n");
            break;
        }
        else{
            global_buffer_empty = 1;
            printf("Consumer in action\n");   
        }
    }
    lpcnet_decoder_destroy(net);
    Pa_Terminate();
    return 0;
}


int main(){
    pthread_t th[2];
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&cond_new_wanted, NULL);
    pthread_cond_init(&cond_new_ready, NULL);

    global_buffer = malloc(96);
    size_t i;

    for(i = 0; i < 2; i++){
        if(i == 0){
            pthread_create(&th[i], NULL, &upload_data, NULL);
        }
        else{
            pthread_create(&th[i], NULL, &fetch_data, NULL);
        }
    }


    for(i = 0; i < 2; i++){
        pthread_join(th[i], NULL);
    }

// set the total number of frames to be recorded
    data.maxFrameIndex = totalFrames = NUM_SECONDS * SAMPLE_RATE;
    data.frameIndex = 0;
    numSamples = totalFrames * NUM_CHANNELS;
    numBytes = numSamples * sizeof(SAMPLE);
    data.recordedSamples = (SAMPLE *) malloc( numBytes );

    FILE *fid;
    fid = fopen("input.pcm", "rb");
    fread(data.recordedSamples, NUM_CHANNELS * sizeof(SAMPLE), totalFrames, fid);
    fclose(fid);

    err = Pa_Initialize();
    // if( err != paNoError ) goto done;

    /* Playback recorded data.  -------------------------------------------- */
    outputParameters.device = Pa_GetDefaultOutputDevice(); /* default output device */
    if (outputParameters.device == paNoDevice) {
        fprintf(stderr,"Error: No default output device.\n");
        // goto done;
    }
    outputParameters.channelCount = NUM_CHANNELS;
    outputParameters.sampleFormat =  PA_SAMPLE_TYPE;
    outputParameters.suggestedLatency = Pa_GetDeviceInfo( outputParameters.device )->defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = NULL;


    printf("\n=== Now playing back. ===\n"); fflush(stdout);
    err = Pa_OpenStream(
            &stream,
            NULL, /* no input */
            &outputParameters,
            SAMPLE_RATE,
            FRAMES_PER_BUFFER,
            paClipOff,      /* we won't output out of range samples so don't bother clipping them */
            playCallback,
            &data );
    // if( err != paNoError ) goto done;

    if( stream )
    {
        err = Pa_StartStream( stream );
        // if( err != paNoError ) goto done;

        printf("Waiting for playback to finish.\n"); fflush(stdout);

        while( ( err = Pa_IsStreamActive( stream ) ) == 1 ) Pa_Sleep(100);
        // if( err < 0 ) goto done;

        err = Pa_CloseStream( stream );
        // if( err != paNoError ) goto done;
    }


    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond_new_wanted);
    pthread_cond_destroy(&cond_new_ready);
    return 0;
}