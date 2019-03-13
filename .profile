#!/bin/bash
# .bash_profile

# Exports
export PATH="$PATH:$HOME/.local/bin"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"

export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export SCRIPTS="$HOME/.scripts"

## Run bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"
