# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html.
# For more examples on how to use CMake, see https://github.com/android/ndk-samples.

# Sets the minimum CMake version required for this project.
cmake_minimum_required(VERSION 3.6)

# Declares the project name. The project name can be accessed via ${ PROJECT_NAME},
# Since this is the top level CMakeLists.txt, the project name is also accessible
# with ${CMAKE_PROJECT_NAME} (both CMake variables are in-sync within the top level
# build script scope).
project("mynativelib")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds them for you.
# Gradle automatically packages shared libraries with your APK.
#
# In this top level CMakeLists.txt, ${CMAKE_PROJECT_NAME} is used to define
# the target library name; in the sub-module's CMakeLists.txt, ${PROJECT_NAME}
# is preferred for the same purpose.
#
# In order to load a library into your app from Java/Kotlin, you must call
# System.loadLibrary() and pass the name of the library defined here;
# for GameActivity/NativeActivity derived applications, the same library name must be
# used in the AndroidManifest.xml file.
#idk
#set(COCOS2DX_ROOT_PATH C:/LamGame/MyLuaGame/frameworks/cocos2d-x/runtime-src/proj.android/thanthu_v2/src/main)
set(COCOS2DX_ROOT_PATH C:/LamGame/MyLuaGame/frameworks/cocos2d-x)

add_library(${CMAKE_PROJECT_NAME} SHARED
        # List C/C++ source files with relative paths to this CMakeLists.txt.
        mynativelib.cpp)

# idk
include_directories(${COCOS2DX_ROOT_PATH}/cocos/platform/android ${COCOS2DX_ROOT_PATH}/cocos)
#
#add_library(39285EFA SHARED IMPORTED)
#set_target_properties(39285EFA PROPERTIES IMPORTED_LOCATION
#        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${ANDROID_ABI}/lib39285EFA.so)
#
#add_library(Bugly SHARED IMPORTED)
#set_target_properties(Bugly PROPERTIES IMPORTED_LOCATION
#        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${ANDROID_ABI}/libBugly.so)
#
#add_library(cocos2dluar SHARED IMPORTED)
#set_target_properties(cocos2dluar PROPERTIES IMPORTED_LOCATION
#        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${ANDROID_ABI}/libcocos2dluar.so)

add_library(frida-gadget SHARED IMPORTED)
set_target_properties(frida-gadget PROPERTIES IMPORTED_LOCATION
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${ANDROID_ABI}/libfrida-gadget.so)
#
#add_library(gavesec SHARED IMPORTED)
#set_target_properties(gavesec PROPERTIES IMPORTED_LOCATION
#        ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${ANDROID_ABI}/libgavesec.so)

#message(CMAKE_CURRENT_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")
#idk
#link_directories(C:/LamGame/MyLuaGame/frameworks/cocos2d-x/runtime-src/proj.android/thanthu_v2/src/main/jniLibs/${ANDROID_ABI}/)

# Specifies libraries CMake should link to your target library. You
# can link libraries from various origins, such as libraries defined in this
# build script, prebuilt third-party libraries, or Android system libraries.
target_link_libraries(${CMAKE_PROJECT_NAME}
        # List libraries link to the target library
        android
#        39285EFA
#        Bugly
#        gavesec
#        cocos2dluar
        frida-gadget
        log)