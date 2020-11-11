#!/bin/bash

set -e

export PATH=$PATH:~/.local/bin
FNAME=ergodox_ez_jon.hex

rm -f $FNAME
make ergodox_ez:jon


