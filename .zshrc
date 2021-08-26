#########
# ALIAS #
#########

[ -f $HOME/.aliases ] && source $HOME/.aliases

############
# FUCTIONS #
############

youtube() {
    workonenv
    workon mps-youtube
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
    local_ignores="""\
### Local Ignores ###
generate-tags.sh
compile_commands.json
"""
    remote_ignores=$(curl -L -s "https://www.gitignore.io/api/windows,linux,osx,vim,emacs,code,$*")
    echo "$local_ignores$remote_ignores"
}

run_swallow() {
  echo
  eval swallow "$BUFFER"
  BUFFER=''
  zle reset-prompt
}

#################
##  ZNAP STUFF  #
#################

export ZNAP_HOME="$ZSH_CONFIGS/znap"
source "$ZNAP_HOME/zsh-snap/znap.zsh"

# prompt
znap source mafredri/zsh-async
znap prompt sindresorhus/pure

# highlighting
znap source zdharma/fast-syntax-highlighting
# completions
znap source zsh-users/zsh-completions

##################
# CONFIGURATIONS #
##################

# pure
zstyle :prompt:pure:git:stash show yes

# History
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
HISTFILE=~/.config/zsh/zsh_history
SAVEHIST=10000
HISTSIZE=10000

# Completion
ZSH_DISABLE_COMPFIX=true

autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zmodload zsh/complist
compinit

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# ZLE hooks for prompt's vi mode status
function zle-line-init zle-keymap-select {
	# Change the cursor style depending on keymap mode.
	case $KEYMAP {
		vicmd)
			printf '\e[0 q' # Box.
			;;

		viins|main)
			printf '\e[6 q' # Vertical bar.
			;;
	}
}
zle -N zle-line-init
zle -N zle-keymap-select

# swallow keybinding
zle -N run_swallow
bindkey '^P' run_swallow

#################
# FZF OVERWRITE #
#################

# Initialize fzf
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

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
