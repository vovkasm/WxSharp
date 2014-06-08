CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
PROJECT(WxNet)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(WxNet_VERSION 1.0.0.0)

if( CMAKE_SIZEOF_VOID_P EQUAL 8 AND NOT WIN32 )
    # On Mac we build 32-bit library by default, because mono with Xamarin Studio is 32bit
    if(APPLE)
        option(WxNet_BUILD_32_BITS "Build 32 bits executables and libraries." ON)
    else(APPLE)
        option(WxNet_BUILD_32_BITS "Build 32 bits executables and libraries." OFF)
    endif(APPLE)

    if( WxNet_BUILD_32_BITS )
        message(STATUS "Building 32 bits executables and libraries.")
        add_definitions(-m32)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -m32")
        set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -m32")
        set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -m32")
    endif( WxNet_BUILD_32_BITS )
endif()

if(NOT LIBRARY_OUTPUT_PATH)
    set(LIBRARY_OUTPUT_PATH ${WxNet_BINARY_DIR}/bin CACHE PATH "Single output directory for building all libraries.")
    mark_as_advanced(LIBRARY_OUTPUT_PATH)
endif()

add_subdirectory(wxc)
add_subdirectory(swig)
add_subdirectory(sample)
