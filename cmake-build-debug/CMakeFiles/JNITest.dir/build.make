# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

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

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/mactty/workspace/study/JNITest

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/mactty/workspace/study/JNITest/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/JNITest.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/JNITest.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/JNITest.dir/flags.make

CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o: CMakeFiles/JNITest.dir/flags.make
CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o: ../register_StaticRegister.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o -c /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp

CMakeFiles/JNITest.dir/register_StaticRegister.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JNITest.dir/register_StaticRegister.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp > CMakeFiles/JNITest.dir/register_StaticRegister.cpp.i

CMakeFiles/JNITest.dir/register_StaticRegister.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JNITest.dir/register_StaticRegister.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp -o CMakeFiles/JNITest.dir/register_StaticRegister.cpp.s

# Object files for target JNITest
JNITest_OBJECTS = \
"CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o"

# External object files for target JNITest
JNITest_EXTERNAL_OBJECTS =

libJNITest.dylib: CMakeFiles/JNITest.dir/register_StaticRegister.cpp.o
libJNITest.dylib: CMakeFiles/JNITest.dir/build.make
libJNITest.dylib: CMakeFiles/JNITest.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libJNITest.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/JNITest.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/JNITest.dir/build: libJNITest.dylib

.PHONY : CMakeFiles/JNITest.dir/build

CMakeFiles/JNITest.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/JNITest.dir/cmake_clean.cmake
.PHONY : CMakeFiles/JNITest.dir/clean

CMakeFiles/JNITest.dir/depend:
	cd /Users/mactty/workspace/study/JNITest/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/mactty/workspace/study/JNITest /Users/mactty/workspace/study/JNITest /Users/mactty/workspace/study/JNITest/cmake-build-debug /Users/mactty/workspace/study/JNITest/cmake-build-debug /Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles/JNITest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/JNITest.dir/depend

