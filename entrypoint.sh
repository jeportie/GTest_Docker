#!/bin/sh
set -e

cd /project

# Clean out the old build if it exists to avoid stale CMakeCache issues :contentReference[oaicite:6]{index=6}
rm -rf build/*
mkdir -p build
cd build

# Configure, compile, and run tests
cmake ..
make
ctest
