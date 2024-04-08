#!/usr/bin/env bash

dut=./build/main

set -e

test_function() {
    echo "========================================================="
    local build_cmd="$1"
    local expect_output="$2"
    echo "build command \"$build_cmd\""
    rm -rf build
    $build_cmd
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Fail with command \"$(build_cmd)\""
    fi

    echo "Build target $dut"
    ninja -C build -v all
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Fail with command \"$(build_cmd)\""
    fi

    echo "===== Execute $dut ====="
    local output=$("$dut")
    if [ "$output" == "$expect_output" ]; then
        echo "The output strings are equal"
    else
        echo "The output strings are not equal, expect \"$expect_output\", return \"$output\""
        exit 1
    fi
    echo "========================================================="
}

cmake_build() {
    local clang_flag="$1"
    local build_type="$2"
    local expect_output="$3"
    
    test_function "cmake -S . -B build -G Ninja -DUSE_CLANG=$clang_flag -DCMAKE_BUILD_TYPE=$build_type" "$expect_output"
}

cmake_build ON Debug "Hello world 30,CLANG"
cmake_build OFF Release "Hello world 30,GNU"
cmake_build ON Debug "Hello world 30,CLANG"
cmake_build OFF Release "Hello world 30,GNU"

echo "===== All test cases PASS ====="

