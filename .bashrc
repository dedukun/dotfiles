#.bashrc
PS1='[\[\033[1;32m\]\u@\h:\[\033[0m\]\W] \$ '

EDITOR=vim

# activate vi mode in bash
set -o vi

# disable automatically executing !, !!, !?, instead filling the bash with the command
shopt -s histverify

# Add local bin to path for personal applications
export PATH=$PATH:$HOME/.local/bin

# Add pic 32 tools
if [ -d /opt/pic32mx/bin ] ; then
 export PATH=$PATH:/opt/pic32mx/bin
fi

# export go path
export GOPATH="$HOME/.config/go"

# activate bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Add color
eval "$(dircolors -b)"

# User defined aliases
alias ls='ls --color=auto'
alias  l='ls -l'
alias ll='ls -la'
alias grep='grep --color'
alias xxstartx='exec startx &> /dev/null'

# Export alias
alias vimtex='export PATH=$PATH:$HOME/.vim/plugged/vim-live-latex-preview/bin'
alias exsbin='export PATH=$PATH:/sbin'

# Tmp alias
alias cd5='cd $HOME/UA/5Ano/'

#To clean up and cover your tracks once you log off
#trap "rm -f ~$LOGNAME/.bash_history" 0
