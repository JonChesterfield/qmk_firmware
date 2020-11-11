#!/bin/bash

set -e
set -o pipefail
set -x

export PATH=$PATH:~/.local/bin

TMP=/tmp/ergodox
mkdir -p $TMP

rm -rf $TMP/*

FNAME=ergodox_ez_jon.hex

SRCZIP=`ls -t  ~/Downloads/ergodox_ez_shine_*.zip  | head -n 1`

echo "Reading from src $SRCZIP"

unzip $SRCZIP -d $TMP/

for s in keymap.c config.h; do
    cp $TMP/ergodox_ez_shine_jon_source/$s keyboards/ergodox_ez/keymaps/jon/
done

rm -f $FNAME
make ergodox_ez:jon
wally-cli $FNAME

