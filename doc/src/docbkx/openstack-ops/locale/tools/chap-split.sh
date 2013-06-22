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

mkdir -p $WORKDIR

# Convert file location format which gettext tools (msgmerge, ..) recognizes.
sed -e 's/^\(#: .*xml\)\([0-9][0-9]*\)(.*)/\1:\2/' $POFILE > $WORKDIR/_base.po

# Get chapter list
grep '^#: ' $POFILE \
| awk '{print $2;}' \
| cut -d '(' -f 1 \
| sed -e 's/xml[0-9]*/xml/' \
| sort \
| uniq > $WORKDIR/_chap.txt

for chap in `cat $WORKDIR/_chap.txt`; do
  msggrep -N $chap $WORKDIR/_base.po --sort-by-file > $WORKDIR/$(basename $chap).ja.po
  echo $chap
done

rm -f $WORKDIR/_chap.txt
rm -f $WORKDIR/_base.po
