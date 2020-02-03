# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="Ducula/ducula"
# ZSH_THEME="oxide"
# ZSH_THEME="lambda-mod"
# ZSH_THEME="zeta"
# ZSH_THEME="punctual"
ZSH_THEME="spaceship"

SPACESHIP_VI_MODE_SHOW="false"
SPACESHIP_TIME_SHOW="true"
SPACESHIP_USER_SHOW="always"
SPACESHIP_BATTERY_THRESHOLD="15"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-completions zsh-vim-mode git-prompt)

source $ZSH/oh-my-zsh.sh

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff steady underline"

# User defined aliases
unalias -a
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/junegunn/fzf/issues/1309
# Remove repeated entries from fzf history search
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -rl 1 |
    sort -k2 -k1rn | uniq -f 1 | sort -r -n |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
