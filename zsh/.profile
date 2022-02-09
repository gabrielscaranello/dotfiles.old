# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


PATH="/usr/local/android-studio/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.yarn/bin:$PATH"
PATH="$HOME/development/flutter/bin:$PATH"
PATH="$HOME/development/flutter/.pub-cache/bin:$PATH"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
PATH="$PATH:$ANDROID_SDK_ROOT/tools"
PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
PATH="$PATH:/opt/gradle/gradle-7.0.2/bin:$PATH"

source /usr/share/nvm/init-nvm.sh

# Fix Tilix, open new split in CWD 
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
