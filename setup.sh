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

PGM="$0"
PWD=$( pwd )
TS=$(date +%s)
SRCFN=tmux.conf
TGTFN="${HOME}/.$SRCFN"
SRC_CONF_DIR=tmux/config
TGT_CONF_DIR="${HOME}/.$SRC_CONF_DIR"

# Attempt to find absolute path to file
basedn=$( dirname "$PGM" )
workdir=$( readlink -e "$basedn" )
abs_fn="${workdir}/$SRCFN"
[[ -f "$abs_fn" ]] || die "Unable to find absolute path for source $SRCFN"

# Install conf file
install -vbC -S "$TS" "$SRCFN" "$TGTFN"

# Install config files
mkdir -p "$TGT_CONF_DIR"
install -vbC -S "$TS" -t "$TGT_CONF_DIR" "$SRC_CONF_DIR/"*
#find "$SRC_CONF_DIR" -type f -print \
#| while read; do
#    fn=$( basename "$REPLY" )
#    install -vbC -S "$TS" -T "$REPLY" "$TGT_CONF_DIR/$fn"
#done
