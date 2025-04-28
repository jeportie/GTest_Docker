#!/bin/sh
set -e

IMAGE_NAME="gtest-runner"

echo "Building Docker image as '${IMAGE_NAME}'..."
docker build -t "${IMAGE_NAME}" .

# Define the alias command (mount entire project root)
ALIAS_CMD='alias runtest='"'"'docker run --rm \
  -v "$(pwd)":/project \
  -v "$(pwd)/build":/project/build \
  gtest-runner'"'"''


# Try to install into /usr/local/bin
if install -m 0755 /dev/null /usr/local/bin/runtest 2>/dev/null; then
  echo "#!/bin/sh" > /usr/local/bin/runtest
  echo "${ALIAS_CMD#alias }" >> /usr/local/bin/runtest
  chmod +x /usr/local/bin/runtest
  echo "Installed wrapper to /usr/local/bin/runtest"
else
  # Fallback: append to shell rc
  SHELL_RC="$HOME/.zshrc"
  [ -n "$BASH_VERSION" ] && SHELL_RC="$HOME/.bashrc"

  # Only append if not already present
  if ! grep -Fxq "${ALIAS_CMD}" "$SHELL_RC"; then
    echo "" >> "$SHELL_RC"
    echo "# Docker-backed C++ Google Test runner" >> "$SHELL_RC"
    echo "${ALIAS_CMD}" >> "$SHELL_RC"
    echo "Alias added to ${SHELL_RC}. Please run 'source ${SHELL_RC}' or re-open your shell."
  else
    echo "Alias already present in ${SHELL_RC}."
  fi
fi

echo "Setup complete! Use 'runtest' in any project directory with src/ and test/ subfolders."
