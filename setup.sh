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

PGM="$0"
PWD=$( pwd )
SRCFN=tmux.conf
TGTFN="${HOME}/.$SRCFN"

# Attemp to find absolute path to file
basedn=$( dirname "$PGM" )
workdir=$( readlink -e "$basedn" )
abs_fn="${workdir}/$SRCFN"
[[ -f "$abs_fn" ]] || die "Unable to find absolute path for source $SRCFN"

# Check for existing target
[[ -f "$TGTFN" ]] \
&& continue_or_exit "Can I overwrite your existing $SRCFN file?"
rm -f "$TGTFN"

# Create symlink 
ln -s "$abs_fn" "$TGTFN"
