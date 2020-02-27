#!/bin/sh

#
# Profile
#

#
# PATH
#

# Recursively add directories in "${HOME}/.local/bin".
export PATH="${PATH}:$(find "${HOME}/.local/bin" -name ".?*" -prune -o -type d -print | tr "\n" ":" | sed "s/:*$//")"

#
# Defaults
#

export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"
export FILE="nnn"

