#!/bin/bash

# Bit of an experiment to create a conf/ dir based on "stock" bits plus
# custom overlays. This process needs to be formalized...


DEST=../openidm

STOCK=/tmp/openidm
STOCK=~/packages/openidm


CUSTOM=.

echo "Creating conf"

cp -Rfv $STOCK/{conf,scripts} $DEST/

echo "Run copy-custom.sh"