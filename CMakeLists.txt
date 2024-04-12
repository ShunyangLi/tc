cmake_minimum_required(VERSION 3.8)

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -Xptxas -dlcm=ca")
# set nvcc path and architecture
set(CMAKE_CUDA_COMPILER /usr/local/cuda/bin/nvcc)
set(CMAKE_CUDA_ARCHITECTURES 86)

project(tc LANGUAGES CUDA CXX)

set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -O3") # Added -O3 optimization for CUDA./



find_package(CUDA REQUIRED)
include_directories(${CUDA_INCLUDE_DIRS})

# Fetch additional dependencies
include(FetchContent)
FetchContent_Declare(
        argparse
        GIT_REPOSITORY https://github.com/p-ranav/argparse.git
)
FetchContent_MakeAvailable(argparse)
include(FetchContent)
FetchContent_Declare(loguru
        GIT_REPOSITORY "https://github.com/emilk/loguru" # can be a filesystem path
        GIT_TAG        "master"
)
# set any loguru compile-time flags before calling MakeAvailable()
FetchContent_MakeAvailable(loguru)

# Add the source directory
include_directories(${CMAKE_CURRENT_LIST_DIR}/src)

add_subdirectory(src)

add_executable(tc main.cu)

target_link_libraries(tc PRIVATE  src argparse loguru::loguru)

set_target_properties(tc PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON
        )

