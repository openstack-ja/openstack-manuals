#!/bin/bash

WORKDIR=chap
BASEPO=$WORKDIR/_base.po

if [ "$1" = "" ]; then
  echo "Usage: $0 POFILE"
  exit 1
fi
POFILE=$1

mkdir -p $WORKDIR

# Convert file location format which gettext tools (msgmerge, ..) recognizes.
sed -e 's/^\(#: .*xml\):\?\([0-9][0-9]*\)(.*)/\1:\2/' $POFILE > $BASEPO

# Get chapter list
grep '^#: ' $BASEPO \
| awk '{print $2;}' \
| cut -d '(' -f 1 \
| sed -e 's/xml:[0-9]*/xml/' \
| sort \
| uniq > $WORKDIR/_chap.txt

for chap in `cat $WORKDIR/_chap.txt`; do
  msggrep -N $chap $WORKDIR/_base.po --sort-by-file > $WORKDIR/$(basename $chap).ja.po
  echo $chap
done

rm -f $WORKDIR/_chap.txt
rm -f $BASEPO
