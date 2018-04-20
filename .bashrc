#.bashrc
if [ `id -un` = root ]; then
   PS1='\[\033[1;31m\]\h:\[\033[0m\]\w\$ '
 else
   PS1='\[\033[1;32m\]\h:\[\033[0m\]\w\$ '
fi

#
# Add color
eval `dircolors -b`

# User defined aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias lsp='ls -1 /var/log/packages/'
alias slkf='find ~/Repositories/slackbuilds/ -type d -name '

alias xstartx='exec startx &> /dev/null'

#To clean up and cover your tracks once you log off
trap "rm -f ~$LOGNAME/.bash_history" 0
