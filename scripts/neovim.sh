#! /bin/bash

# Define variables
GIT_URL="https://github.com/neovim/neovim"
BRANCH="stable"
WORK_DIR="/tmp/neovim"

# Remove old files
rm -rf $WORK_DIR

# Clone repository
git clone --depth 1 -b "$BRANCH" "$GIT_URL" "$WORK_DIR"

# Install
cd "$WORK_DIR"
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb && cd "$WORK_DIR"

echo "Neovim installed..."