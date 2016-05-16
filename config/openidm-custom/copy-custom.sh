#!/bin/bash

# copy our custom bits to the target custom dir

DEST=../openidm



CUSTOM=.

echo "Copying custom overlays"

cp -Rfv $CUSTOM/{conf,scripts} $DEST

echo "Deleting files that are not required"

rm -f $DEST/conf/repo.orientdb.json
rm -fr $DEST/db/openidm
