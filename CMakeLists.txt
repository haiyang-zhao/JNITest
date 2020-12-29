cmake_minimum_required(VERSION 3.17)
project(JNITest)

set(CMAKE_CXX_STANDARD 14)

add_library(JNIStatic_reg SHARED register_StaticRegister.cpp register_StaticRegister.h)

add_library(JNTDynamic_reg SHARED register_dynamic.c)