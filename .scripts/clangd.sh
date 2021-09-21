#!/bin/sh
ulimit -v 3000000
clangd "$@"
