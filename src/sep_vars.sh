#!/usr/bin/zsh
VARS = tail -n +2 output/AT_CG.csv | cut -f2 -d "," | sort | uniq
for y in $VARS; do echo $y; done
    