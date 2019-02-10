#!/bin/bash
#.bashrc
PS1='[\[\033[1;32m\]\u@\h:\[\033[0m\]\W] \$ '

# disable automatically executing !, !!, !?, instead filling the bash with the command
shopt -s histverify

# Add pic 32 tools
if [ -d /opt/pic32mx/bin ] ; then
 export PATH=$PATH:/opt/pic32mx/bin
fi

# activate bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Add color
eval "$(dircolors -b)"

# User defined aliases
alias ls='ls -h --color=auto'
alias  l='ls -l'
alias ll='ls -la'
alias grep='grep --color'
alias xxstartx='exec startx &> /dev/null'

# Tmp alias
alias cd5='cd $HOME/UA/5Ano/'

#To clean up and cover your tracks once you log off
#trap "rm -f ~$LOGNAME/.bash_history" 0

# gitignore
gitignore()
{
    curl -L -s "https://www.gitignore.io/api/windows,linux,osx,vim,visualstudiocode,$@"
}
