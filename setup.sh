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

SRCFN="${BASE}/tmux.conf"
TGTFN="${HOME}/.tmux.conf"
SRC_CONF_DIR="${BASE}/tmux/config"
TGT_CONF_DIR="${HOME}/.tmux/config"

# Install conf file
install -vbC -S "$TS" -m 0600 "$SRCFN" "$TGTFN"

# Install config files
install -vbC -S "$TS" -m 0600 -D -t "$TGT_CONF_DIR" "$SRC_CONF_DIR/"*
