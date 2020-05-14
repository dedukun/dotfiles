#!/bin/bash
locate --regex "/tags$" | grep -v ".git/.*/tags$" | xargs ls -lh  | grep "^\-.*/tags$" --color=never | awk '{print $5"\t"$9}'
#./check_tags.sh | grep "Globaltronic" | grep -v "\/doc\/tags"
