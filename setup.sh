#!/bin/bash

function die() {
    echo "FATAL ERROR: $*"
    exit 99
}

function continue_or_exit() {
    local msg="Continue?"
    [[ -n "$1" ]] && msg="$1"
    echo "$msg"
    select yn in "Yes" "No"; do
        case $yn in
            Yes) return 0;;
            No ) exit 1;;
        esac
    done
}

set -x

BASE=$( dirname $0 )
TS=$(date +%s)

SRC_CONF_DIR="${BASE}/config"
TGT_CONF_DIR="${HOME}/.config/tmux"

# Install config files
install -vbC -S "$TS" -m 0600 -D -t "$TGT_CONF_DIR" "$SRC_CONF_DIR/"*.conf

# clean backed up files (so the simple glob in tmux.conf won't match them)
bkup_dir="$TGT_CONF_DIR"/bkup
mkdir -p "$bkup_dir"
find "$TGT_CONF_DIR" -maxdepth 1 -type f -name '*[0-9]' -exec mv {} "$bkup_dir"/ \;
