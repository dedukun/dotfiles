#!/bin/bash
#.bashrc
PS1='[\[\033[1;32m\]\u@\h:\[\033[0m\]\[\033[01;34m\]\W\[\033[00m\]] \$ '

export HISTCONTROL=ignoredups           # dont save duplicate consecutive commands
HISTSIZE=HISTFILESIZE=                  # infinite history
shopt -s histappend                     # append to history, don't overwrite it
PROMPT_COMMAND='history -a; history -n' # update history after each command in multiple terminals

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

# s auto completion
if [ -f $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash ]; then
    . $GOPATH/src/github.com/zquestz/s/autocomplete/s-completion.bash
fi

# Add color
eval "$(dircolors -b)"

# User defined aliases
alias nvim="\$HOME/.local/bin/nvim"
alias vi="nvim"
alias vim="nvim"
alias git="\$SCRIPTS/gbt/git.sh"
alias ag="\$SCRIPTS/ag.sh"
alias ls='ls -h --color=auto --group-directories-first --sort=extension'
alias l='ls -l'
alias ll='ls -lA'
alias less='less -i'
alias grep='grep --color'
alias grep-source='grep --include={*.[hc],*.[hc]pp,*.java,*.py,*.js,*.ejs,*.html,*.sh,*.tex}'
alias xxstartx='exec startx &> /dev/null'
alias update-time='sudo ntpdate pt.pool.ntp.org'
alias gbtcd='cd $(glbt_proj --get)'
alias mtdcd='cd $(mtd --get)'
#alias dmenu='dmenu -i -fn xft:Inconsolata-10 -nb #303030 -nf #909090 -sb #909090 -sf #303030'
alias list-big-files='sudo find / -type f -size +50M -exec du -h {} \; | sort -n'

# wine aliases
alias wine="WINEPREFIX=\$HOME/.wine32 wine"
alias wine64="WINEPREFIX=\$HOME/.wine64 wine64"
alias winecfg="WINEPREFIX=\$HOME/.wine32 winecfg"
alias wine64cfg="WINEPREFIX=\$HOME/.wine64 winecfg"

youtube() {
    workonenv
    workon youtube
    "$HOME/Applications/mps-youtube/mpsyt" "$*"
    deactivate
}

# start python's virtualenvwrapper
workonenv() {
    export WORKON_HOME="$HOME/.virtualenvs"
    export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
    . "$HOME/.local/bin/virtualenvwrapper.sh"
}

pip_upgrade() {

    if [ -z "$1" ]; then
        echo "Missing argument"
        return 1
    fi

    case $1 in
        "2" )
            ;;
        "2.7" )
            ;;
        "3" )
            ;;
        "3.5" )
            ;;
        "3.6" )
            ;;
        "3.7" )
            ;;
        *)
            echo "ERROR: Unknown version '$1'"
            return 1
            ;;

    esac

    sh -c "python$1 -m pip list --outdated | tail -n +3 | awk '{print \$1;}' | xargs python$1 -m pip install --user --upgrade"
}

# gitignore
gitignore() {
    local_ignores="""\
### Local Ignores ###
generate-tags.sh
"""
    remote_ignores=$(curl -L -s "https://www.gitignore.io/api/windows,linux,osx,vim,$*")
    echo "$local_ignores$remote_ignores"
}

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
stopwatch() {
    local date1
    date1=$(date +%s)
    while true; do
        echo -ne "$(date -u --date @$(($(date +%s) - date1)) +%H:%M:%S)\r"
        sleep 0.1
    done
}

# Initialize fzf
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.bash

# https://github.com/junegunn/fzf/issues/1309
# Remove repeated entries from fzf history search
__fzf_history__() {
    local line
    countskip="$(history | tail -n 1 | grep -E '^ *[0-9]+' -o | wc -c)"
    countskip="$((countskip + 1))"
    line=$(
        HISTTIMEFORMAT= history |
            grep '^.\{1,130\}$' --text |
            sed 's/ *$//g' |
            {
                i=$(cat)
                head --lines=-50 <<<"$i"
                cat ~/shared_history | while read line; do echo " 0000  $line"; done
                tail -n 50 <<<"$i"
            } |
            tac |
            nauniq --skip-chars="$countskip" |
            tac |
            $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            \grep '^ *[0-9]'
    ) && sed 's/ *\([0-9]*\)\** \(.*\)/\2/' <<<"$line"
}
