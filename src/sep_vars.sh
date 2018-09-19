#!/usr/bin/zsh
for y in $(tail -n +2 output/AT_CG.csv | cut -f2 -d "," | sort | uniq); do
	echo $y
	for x in output/[A,G]*; do
		echo $x;
	done
done
    
