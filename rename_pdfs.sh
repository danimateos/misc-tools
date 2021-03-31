#! /bin/env bash

newdir=$1
prefix=$2

OLD_IFS=$IFS
IFS=$'\n'

X=1
for f in $(ls -1rt *.pdf); do
  cp $f  ${newdir}/${prefix}$(printf '%.2d_recibo.pdf' $X); X=$((X+1))
done

IFS=$OLD_IFS
