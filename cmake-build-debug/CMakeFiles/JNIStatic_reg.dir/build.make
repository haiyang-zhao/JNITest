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
include CMakeFiles/JNIStatic_reg.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/JNIStatic_reg.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/JNIStatic_reg.dir/flags.make

CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o: CMakeFiles/JNIStatic_reg.dir/flags.make
CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o: ../register_StaticRegister.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o -c /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp

CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp > CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.i

CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/mactty/workspace/study/JNITest/register_StaticRegister.cpp -o CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.s

# Object files for target JNIStatic_reg
JNIStatic_reg_OBJECTS = \
"CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o"

# External object files for target JNIStatic_reg
JNIStatic_reg_EXTERNAL_OBJECTS =

libJNIStatic_reg.dylib: CMakeFiles/JNIStatic_reg.dir/register_StaticRegister.cpp.o
libJNIStatic_reg.dylib: CMakeFiles/JNIStatic_reg.dir/build.make
libJNIStatic_reg.dylib: CMakeFiles/JNIStatic_reg.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libJNIStatic_reg.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/JNIStatic_reg.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/JNIStatic_reg.dir/build: libJNIStatic_reg.dylib

.PHONY : CMakeFiles/JNIStatic_reg.dir/build

CMakeFiles/JNIStatic_reg.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/JNIStatic_reg.dir/cmake_clean.cmake
.PHONY : CMakeFiles/JNIStatic_reg.dir/clean

CMakeFiles/JNIStatic_reg.dir/depend:
	cd /Users/mactty/workspace/study/JNITest/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/mactty/workspace/study/JNITest /Users/mactty/workspace/study/JNITest /Users/mactty/workspace/study/JNITest/cmake-build-debug /Users/mactty/workspace/study/JNITest/cmake-build-debug /Users/mactty/workspace/study/JNITest/cmake-build-debug/CMakeFiles/JNIStatic_reg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/JNIStatic_reg.dir/depend

