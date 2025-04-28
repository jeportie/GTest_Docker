#!/bin/bash
set -e

# Navigate to project root and prepare build directory
echo "Entering project directory..."
cd /project

# Clean out the old build if it exists to avoid stale CMakeCache issues :contentReference[oaicite:6]{index=6}
rm -rf build/*
mkdir -p build
cd build

echo "Configuring and building..."
cmake .. && make

# Run tests and capture result
if ctest; then
    echo "✅ All tests passed. ✅"
    cd /project
    echo "Cleaning up build directory..."
    rm -rf build
    exit 0
else
    echo "❌ Tests failed. ❌"
    echo "Re-running failed tests with detailed output..."
    ctest --rerun-failed --output-on-failure
    cd /project
    echo "Cleaning up build directory..."
    rm -rf build
    exit 1
fi
