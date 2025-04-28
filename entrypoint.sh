#!/bin/sh
set -e

cd /project

mkdir -p build
cd build

# Configure, compile, and run all GoogleTest tests
cmake ..
make -j"$(nproc)"
ctest --output-on-failure
