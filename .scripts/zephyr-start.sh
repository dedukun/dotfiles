#!/bin/bash

export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
. "$HOME/.local/bin/virtualenvwrapper.sh"

workon zephyr
source "$HOME/GBT/zephyr/zephyrproject/zephyr/zephyr-env.sh"
