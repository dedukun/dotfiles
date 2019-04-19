#!/bin/bash
printf "Preparing terminal for GBT Git Project... "

git config credential.helper 'cache --timeout=1800'
git config user.email diogo.duarte@globaltronic.pt

echo "done"
