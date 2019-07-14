#!/bin/bash
#.bashrc
PS1='[\[\033[1;32m\]\u@\h:\[\033[0m\]\[\033[01;34m\]\W\[\033[00m\]] \$ '

export HISTCONTROL=ignoredups       # dont save duplicate consecutive commands
HISTSIZE=HISTFILESIZE=              # infinite history
shopt -s histappend                 # append to history, don't overwrite it
[[ $(echo "$PROMPT_COMMAND" | grep history) ]] || PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"  # update history after each command in multiple terminals

# disable automatically executing !, !!, !?, instead filling the bash with the command
shopt -s histverify

# activate bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add color
eval "$(dircolors -b)"

# User defined aliases
alias nvim="$HOME/.local/bin/nvim"
alias vi="nvim"
alias vim="nvim"
alias ls='ls -h --color=auto --group-directories-first'
alias  l='ls -l'
alias ll='ls -lA'
alias grep='grep --color'
alias grep-source='grep --include={*.[hc],*.[hc]pp,*.java,*.py}'
alias xxstartx='exec startx &> /dev/null'
alias update-time='sudo ntpdate pt.pool.ntp.org'
alias gbtcd='cd $(glbt_proj --get)'
#alias dmenu='dmenu -i -fn xft:Inconsolata-10 -nb #303030 -nf #909090 -sb #909090 -sf #303030'

# export python startup file to add autocomplete to python console
export PYTHONSTARTUP="$HOME/.pythonrc.py"

youtube() {
    workonenv
    workon youtube
    mpsyt
    deactivate
}

# start python's virtualenvwrapper
workonenv() {
    export WORKON_HOME="$HOME/.virtualenvs"
    export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
    . "$HOME/.local/bin/virtualenvwrapper.sh"
}

# gitignore
gitignore() {
    curl -L -s "https://www.gitignore.io/api/windows,linux,osx,vim,$*"
}

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
stopwatch(){
    local date1
    date1=$(date +%s);
    while true; do
        echo -ne "$(date -u --date @$(($(date +%s) - date1)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# https://github.com/junegunn/fzf/issues/1309
# Remove repeated entries from history search
__fzf_history__() {
    local line
    countskip="$(history | tail -n 1 | grep -E '^ *[0-9]+' -o | wc -c)"
    countskip="$(( countskip + 1 ))"
    line=$(
    HISTTIMEFORMAT= history |
    grep '^.\{1,130\}$' --text |
    sed 's/ *$//g' |
    { i=$(cat); head --lines=-50 <<<"$i" ; cat ~/shared_history | while read line; do echo " 0000  $line"; done; tail -n 50 <<< "$i"; } |
    tac |
    nauniq --skip-chars="$countskip" |
    tac |
    $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
    \grep '^ *[0-9]') && sed 's/ *\([0-9]*\)\** \(.*\)/\2/' <<< "$line"
}
