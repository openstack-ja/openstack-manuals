#!/bin/bash

POTFILE=openstack-ops.pot
POFILE=ja.po
WORKDIR=chap

if [ ! -f $POFILE ]; then
  echo "$POFILE not found"
  exit 1
fi
if [ ! -f $POTFILE ]; then
  echo "$POTFILE not found"
  exit 1
fi
if [ ! -d $WORKDIR ]; then
  echo "$WORKDIR not found"
  exit 1
fi

TMPFILE=$WORKDIR/$$.po

# Merge all files (sorting by file location)
msgcat -F $WORKDIR/*.xml.ja.po > $TMPFILE

# Sync with the source lang
# It is required to sync the format of file location.
# xml2po uses the different format than the format gettext tools recognizes.
msgmerge -F $TMPFILE $POTFILE > $POFILE

rm -f $TMPFILE
