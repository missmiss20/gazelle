# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.21.4/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.21.4/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/mymac/Desktop/test-portaudio-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/mymac/Desktop/test-portaudio-master/build

# Include any dependencies generated for this target.
include CMakeFiles/sample_portaudio.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/sample_portaudio.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/sample_portaudio.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sample_portaudio.dir/flags.make

CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o: CMakeFiles/sample_portaudio.dir/flags.make
CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o: ../sample_portaudio.c
CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o: CMakeFiles/sample_portaudio.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/mymac/Desktop/test-portaudio-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o -MF CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o.d -o CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o -c /Users/mymac/Desktop/test-portaudio-master/sample_portaudio.c

CMakeFiles/sample_portaudio.dir/sample_portaudio.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_portaudio.dir/sample_portaudio.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/mymac/Desktop/test-portaudio-master/sample_portaudio.c > CMakeFiles/sample_portaudio.dir/sample_portaudio.c.i

CMakeFiles/sample_portaudio.dir/sample_portaudio.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_portaudio.dir/sample_portaudio.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/mymac/Desktop/test-portaudio-master/sample_portaudio.c -o CMakeFiles/sample_portaudio.dir/sample_portaudio.c.s

# Object files for target sample_portaudio
sample_portaudio_OBJECTS = \
"CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o"

# External object files for target sample_portaudio
sample_portaudio_EXTERNAL_OBJECTS =

bin/sample_portaudio: CMakeFiles/sample_portaudio.dir/sample_portaudio.c.o
bin/sample_portaudio: CMakeFiles/sample_portaudio.dir/build.make
bin/sample_portaudio: /usr/local/include/portaudio/lib/libportaudio.a
bin/sample_portaudio: CMakeFiles/sample_portaudio.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/mymac/Desktop/test-portaudio-master/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable bin/sample_portaudio"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sample_portaudio.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sample_portaudio.dir/build: bin/sample_portaudio
.PHONY : CMakeFiles/sample_portaudio.dir/build

CMakeFiles/sample_portaudio.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sample_portaudio.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sample_portaudio.dir/clean

CMakeFiles/sample_portaudio.dir/depend:
	cd /Users/mymac/Desktop/test-portaudio-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/mymac/Desktop/test-portaudio-master /Users/mymac/Desktop/test-portaudio-master /Users/mymac/Desktop/test-portaudio-master/build /Users/mymac/Desktop/test-portaudio-master/build /Users/mymac/Desktop/test-portaudio-master/build/CMakeFiles/sample_portaudio.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sample_portaudio.dir/depend

