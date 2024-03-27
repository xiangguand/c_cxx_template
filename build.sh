#!/usr/bin/env bash
### Author: Xiang Guan Deng.

set -e

echo "===== Start building ====="

cmake -S . -B build -G"Ninja"
ninja -C build

echo "===== Build successfully ====="
