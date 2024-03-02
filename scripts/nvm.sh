#! /bin/bash
# shellcheck disable=2155,2002,2046

# Define variables
NODE_VERSION=20
NVM_VERSION=0.39.7

# Cloning NVM
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash

# Exporting NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Installing Node
nvm install "${NODE_VERSION}"

# Activating Node
nvm use "${NODE_VERSION}"

# Installing Yarn
npm i -g yarn

# Installing Node Packages
yarn global add $(cat ./node_packages | tr '\n' ' ')
