#!/bin/bash

export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
. "$HOME/.local/bin/virtualenvwrapper.sh"

workon nrfconnect
source "$HOME/GBT/nrf/ncs/zephyr/zephyr-env.sh"
