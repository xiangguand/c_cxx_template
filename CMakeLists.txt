cmake_minimum_required(VERSION 3.16)

project(main)

if(USE_CLANG)
    message(STATUS "Using clang compiler")
    set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cmake/clang_toolchain.cmake")
else()
    message(STATUS "Using GCC compiler")
    set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cmake/gnu.cmake")
endif()

include(${CMAKE_TOOLCHAIN_FILE})

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

option(CODE_COVERAGE ON)
option(USE_WARNING_FLAGS ON)
option(USE_CLANG OFF)
# option(DEBUG ON)

set(CMAKE_CXX_FLAGS_DEBUG_INIT "-O0 -g")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-O3")

if(Debug)
    message(STATUS "===== Debug =====")
    list(APPEND CMAKE_C_FLAGS
        -O0
    )
    list(APPEND CMAKE_CXX_FLAGS
        -O0
    )
else()
    message(STATUS "===== Release =====")
    list(APPEND CMAKE_C_FLAGS
        -O3
    )
    list(APPEND CMAKE_CXX_FLAGS
        -O3
    )
endif()

set(WARNING_FLAGS
    -pedantic
    -Wall
    -Wfatal-errors
    -Wextra
    -Wno-unused-parameter
    -Wno-unused-variable
)

if(WARNING_FLAGS)
    # Append warning flags to C compiler flags
    add_compile_options("$<$<COMPILE_LANGUAGE:C>:${WARNING_FLAGS}>")

    # Append warning flags to C++ compiler flags
    add_compile_options("$<$<COMPILE_LANGUAGE:CXX>:${WARNING_FLAGS}>")
endif()

string(REPLACE ";" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE ";" " " CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

# SET(CFLAGS
#     -Waddress
#     -Waggregate-return
#     -Wformat-nonliteral
#     -Wformat-security
#     -Wformat
#     -Winit-self
#     -Wmissing-declarations
#     -Wmissing-include-dirs
#     -Wno-multichar
#     -Wno-parentheses
#     -Wno-type-limits
#     -Wno-unused-parameter
#     -Wunreachable-code
#     -Wwrite-strings
#     -Wpointer-arith
#     # -Werror
#     -Wall
# )

# set(LDFLAGS

#     )
set(DEPEN_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)


# add_compile_options(${CFLAGS})
# add_link_options(${LDFLAGS})


set(DEPEN_DIR
    ${DEPEN_DIR}
)




# Assembly file
FILE(GLOB ASMSRC src/*.s)
# C file
FILE(GLOB CSRC src/*.c)
# C++ file
FILE(GLOB CXXSRC src/*.cpp)

set_property(SOURCE ${ASMSRC} PROPERTY LANGUAGE C)

set(SOURCE_FILE
  ${CSRC}
  ${CXXSRC}
  ${ASMSRC} 
)

# generate the main executable ifle
add_executable(${PROJECT_NAME} ${SOURCE_FILE})

# Include reference
target_include_directories(${PROJECT_NAME} PUBLIC ${DEPEN_DIR})


# library directory
target_link_libraries(${PROJECT_NAME} PUBLIC
    m
)

