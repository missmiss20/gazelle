# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

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
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/mymac/Desktop/gazelle/automate_playback

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/mymac/Desktop/gazelle/automate_playback/build

# Include any dependencies generated for this target.
include bin/CMakeFiles/Dialling.dir/depend.make

# Include the progress variables for this target.
include bin/CMakeFiles/Dialling.dir/progress.make

# Include the compile flags for this target's objects.
include bin/CMakeFiles/Dialling.dir/flags.make

bin/CMakeFiles/Dialling.dir/Dialling.c.o: bin/CMakeFiles/Dialling.dir/flags.make
bin/CMakeFiles/Dialling.dir/Dialling.c.o: ../src/Dialling.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/mymac/Desktop/gazelle/automate_playback/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object bin/CMakeFiles/Dialling.dir/Dialling.c.o"
	cd /Users/mymac/Desktop/gazelle/automate_playback/build/bin && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Dialling.dir/Dialling.c.o -c /Users/mymac/Desktop/gazelle/automate_playback/src/Dialling.c

bin/CMakeFiles/Dialling.dir/Dialling.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Dialling.dir/Dialling.c.i"
	cd /Users/mymac/Desktop/gazelle/automate_playback/build/bin && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/mymac/Desktop/gazelle/automate_playback/src/Dialling.c > CMakeFiles/Dialling.dir/Dialling.c.i

bin/CMakeFiles/Dialling.dir/Dialling.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Dialling.dir/Dialling.c.s"
	cd /Users/mymac/Desktop/gazelle/automate_playback/build/bin && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/mymac/Desktop/gazelle/automate_playback/src/Dialling.c -o CMakeFiles/Dialling.dir/Dialling.c.s

# Object files for target Dialling
Dialling_OBJECTS = \
"CMakeFiles/Dialling.dir/Dialling.c.o"

# External object files for target Dialling
Dialling_EXTERNAL_OBJECTS =

bin/Dialling: bin/CMakeFiles/Dialling.dir/Dialling.c.o
bin/Dialling: bin/CMakeFiles/Dialling.dir/build.make
bin/Dialling: bin/CMakeFiles/Dialling.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/mymac/Desktop/gazelle/automate_playback/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable Dialling"
	cd /Users/mymac/Desktop/gazelle/automate_playback/build/bin && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Dialling.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
bin/CMakeFiles/Dialling.dir/build: bin/Dialling

.PHONY : bin/CMakeFiles/Dialling.dir/build

bin/CMakeFiles/Dialling.dir/clean:
	cd /Users/mymac/Desktop/gazelle/automate_playback/build/bin && $(CMAKE_COMMAND) -P CMakeFiles/Dialling.dir/cmake_clean.cmake
.PHONY : bin/CMakeFiles/Dialling.dir/clean

bin/CMakeFiles/Dialling.dir/depend:
	cd /Users/mymac/Desktop/gazelle/automate_playback/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/mymac/Desktop/gazelle/automate_playback /Users/mymac/Desktop/gazelle/automate_playback/src /Users/mymac/Desktop/gazelle/automate_playback/build /Users/mymac/Desktop/gazelle/automate_playback/build/bin /Users/mymac/Desktop/gazelle/automate_playback/build/bin/CMakeFiles/Dialling.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : bin/CMakeFiles/Dialling.dir/depend

