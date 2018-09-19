#!/usr/bin/zsh
for y in $(tail -n +2 output/AT_CG.csv | cut -f2 -d "," | sort | uniq); do
	head -1 output/AT_CG.csv > output/feature_specific/${${y:gs/\(/}:gs/\)/}.csv
	for x in output/[A,G]*; do
		cat $x | grep $y >> "output/feature_specific/${${y:gs/\(/}:gs/\)/}.csv"
	done
done
    
