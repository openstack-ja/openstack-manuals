#!/bin/bash

POTFILE=openstack-ops.pot
POFILE=ja.po
WORKDIR=_work
WORKBRANCH=trans-ja-opsguide

if [ ! -f $POFILE ]; then
  echo "$POFILE not found"
  exit 1
fi
if [ ! -f $POTFILE ]; then
  echo "$POTFILE not found"
  exit 1
fi
mkdir -p $WORKDIR

git checkout $WORKBRANCH
git remote update

BRANCHES=$(git branch -r --list "origin/trans-ja/*" | sed -e 's/^..origin\///')
for b in $BRANCHES; do
  git checkout $b
  git merge origin/$b
  cp -i -p chap/*.xml.ja.po $WORKDIR
done
git checkout $WORKBRANCH

TMPFILE=$WORKDIR/$$.po

# Merge all files (sorting by file location)
msgcat -F $WORKDIR/*.xml.ja.po > $TMPFILE

# Sync with the source lang
# It is required to sync the format of file location.
# xml2po uses the different format than the format gettext tools recognizes.
msgmerge -F $TMPFILE $POTFILE > $POFILE

rm -f $TMPFILE
rm -rf $WORKDIR
