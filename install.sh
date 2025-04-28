#!/bin/sh
set -e

IMAGE_NAME="gtest-runner"

echo "Building Docker image as '${IMAGE_NAME}'..."
docker build -t "${IMAGE_NAME}" .

echo "Installing 'runtest' wrapper to /usr/local/bin..."
cat > /usr/local/bin/runtest << 'EOF'
#!/bin/sh
# mounts only src, test, build into container and runs tests
PROJECT_DIR="$(pwd)"
docker run --rm \
  -v "${PROJECT_DIR}/src":/project/src \
  -v "${PROJECT_DIR}/test":/project/test \
  -v "${PROJECT_DIR}/build":/project/build \
  gtest-runner
EOF
chmod +x /usr/local/bin/runtest

echo "Done! Now you can cd into any C++ project with 'src/' and 'test/' and run 'runtest'."
