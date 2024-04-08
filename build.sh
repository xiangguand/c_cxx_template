#!/usr/bin/env bash
### Author: Xiang Guan Deng.

set -e

echo "===== Start building ====="

cmake -S . -B build -G"Ninja" -DUSE_CLANG=ON -DCMAKE_BUILD_TYPE=Debug
ninja -C build

echo "===== Build successfully ====="
