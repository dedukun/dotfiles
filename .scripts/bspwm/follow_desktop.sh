#!/bin/bash

node_tag="_FOLLOW_DESKTOP"
follow_cache_file="$SCRIPTS/.cache/bspwm_follow"

#######################
# 'PRIVATE' FUNCTIONS #
#######################

_exit_error() {
    notify-send -t 1500 -u critical "ERROR" "$1"
    exit 1
}

_print_info() {
    notify-send -t 1500 "Follow Desktop" "$1"
}

_check_tag() {
  i=$(for w in $(xwininfo -root -children | grep -e "^\s*0x[0-9a-f]\+" -o);do
      t=$(xprop -id $w $node_tag | grep ' = \(.*\)');
      if [ -n "$t" ]; then
          echo $t $w;
          return
      fi;
      done|sort -n|cut -d" " -f 5)

  echo "$i"
}

_get_tags_ids() {
  i=$(for w in $(xwininfo -root -children | grep -e "^\s*0x[0-9a-f]\+" -o);do
      t=$(xprop -id $w $node_tag | grep ' = \(.*\)');
      if [ -n "$t" ]; then
          echo $t $w;
      fi;
      done|sort -n|cut -d" " -f 5)

  echo "$i"
}

_check_subscribe_running() {
  cached_pid="$(cat $follow_cache_file)"

  if [ "$cached_pid" == "" ]; then
    echo ""
  else
    ps aux | awk '{ print $2; }' | grep "$cached_pid"
  fi
}

_kill_running_subscribe() {
  cat "$follow_cache_file" | xargs kill -9 &> /dev/null
  rm "$follow_cache_file"
  touch "$follow_cache_file"
}

_start_subscribe() {
  while read EVENT
  do
    desktop_id=$(bspc query -D -d "focused")
    while read NODE_ID
    do
      bspc node "$NODE_ID" -d "$desktop_id"
    done < <(_get_tags_ids)
  done < <(bspc subscribe desktop_focus)
}

######################
# 'PUBLIC' FUNCTIONS #
######################

toggle_follow() {
  id=$(bspc query -N -n "focused")

  [ ! -n "$id" ] && _exit_error "No focused node"

  tag_query="$(xprop -id $id $node_tag)"

  if [ "$(echo $tag_query | grep -i no)" ]; then
    xprop -id $id -f $node_tag 32ii -set $node_tag $(date +%s,%N)

    if [ "$(_check_subscribe_running)" == "" ]; then
      _print_info "Added tag*"
      _start_subscribe &
      echo $! >> "$follow_cache_file"
      return
    fi

    _print_info "Added tag"
  else
    xprop -id $id -remove $node_tag

    if [ "$(_check_tag)" == "" ]; then
      _print_info "Remove tag*"
      _kill_running_subscribe
      return
    fi

    _print_info "Remove tag"
  fi
}

#################
# MAIN FUNCTION #
#################

case $1 in
  toggle_follow)  toggle_follow;;
    *) _exit_error "Unkown option '$1'";;
esac
