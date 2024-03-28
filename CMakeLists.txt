cmake_minimum_required(VERSION 3.16)

project(main)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

option(CODE_COVERAGE ON)

set(WARNINGS
    -pedantic
    -Wall
    -Wfatal-errors
    -Wextra
    -Wno-unused-parameter
    -Wno-unused-variable
)

SET(CFLAGS
    -Waddress
    -Waggregate-return
    -Wformat-nonliteral
    -Wformat-security
    -Wformat
    -Winit-self
    -Wmissing-declarations
    -Wmissing-include-dirs
    -Wno-multichar
    -Wno-parentheses
    -Wno-type-limits
    -Wno-unused-parameter
    -Wunreachable-code
    -Wwrite-strings
    -Wpointer-arith
    # -Werror
    -Wall
)

set(LDFLAGS

    )
set(DEPEN_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)


add_compile_options(${CFLAGS})
add_link_options(${LDFLAGS})


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

