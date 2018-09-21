% Compare-Results
% Andy Beck

# Abstract

# Introduction

The goal of this (mini) project is to compare the results from running the [smaug-genetics](http://github.com/carjed/smaug-genetics) pipeline
on the same dataset. Numerical differences were observed in some of the outputs, and this likely resulted from the github repository being put together
after all the analyses had been run initially (likely multiple times per step and not necessarily in the order described in the repository's documentation).

Here in this analysis, we compare the results of the logistic regression models used to predict the mutation rates for each 7-mer mutation type, conditioned
on 14 genomic features (for more details, see the paper [Extremely rare variants reveal patterns of germline mutation rate heterogeneity in humans](https://www.nature.com/articles/s41467-018-05936-5).

# Data
Each of the six mutation types (AT\_CG, AT\_GC, AT\_TA, GC\_AT, GC\_CG, GC\_TA) has its own subdirectory in `output\logmod_data\coefs`. Inside each mutation type directory are 
4096 files, each corresponding to one 7-mer with the mutation type at the center. Each of these files contains the following table (with no header row:)

|Covariate|Estimate|SE|Z|pval|motif|
|:-------:|:------:|:-:|:-:|:-----:|
|(Intercept)|*est*|*SE*|*Z*|*p*|AAAAAAA|
|DP       |*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K4me1|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K4me3|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K9ac|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K9me3|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K27ac|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K27me3|*est*|*SE*|*Z*|*p*|AAAAAAA|
|H3K36me3|*est*|*SE*|*Z*|*p*|AAAAAAA|
|EXON|*est*|*SE*|*Z*|*p*|AAAAAAA|
|CpGI|*est*|*SE*|*Z*|*p*|AAAAAAA|
|RR|*est*|*SE*|*Z*|*p*|AAAAAAA|
|LAMIN|*est*|*SE*|*Z*|*p*|AAAAAAA|
|DHS|*est*|*SE*|*Z*|*p*|AAAAAAA|
|TIME|*est*|*SE*|*Z*|*p*|AAAAAAA|
|GC|*est*|*SE*|*Z*|*p*|AAAAAAA|


# Method

## Statistics that might be useful to capture

1. Difference in the beta values for each parameter
2. Does direction of statistic match?
3. Difference between pvalues

### Computig the above statistics

For each mutation type, we run `src/compare_coef.py n` (n = 0, 1, 2, 3, 4, or 5), which generates a resulting file in `output/`. For each mutation type, we have the following table:

|Motif|Var|BetaDiff|SignBeta|PDiff|
|:---:|:-:|:------:|:------:|:---:|
|AT\_CG\_AACACGC|(Intercept)|0.05011159999999926|1|5.348999999999999e-05|

Where SignBeta = true if the signs of the coefficients are the same

I then generated files for each covariate (and the intercept) using similar shell commands as the following:

```bash
head -1 AT_CG.csv > Intercept.csv
for x in AT_CG.csv AT_GC.csv AT_TA.csv GC_AT.csv GC_CG.csv GC_TA.csv; do cat $x | \
grep '(Intercept)' >> Intercept.csv; done
```

Or we can do it all in one script:

```bash
#!/usr/bin/zsh
for y in $(tail -n +2 output/AT_CG.csv | cut -f2 -d "," | sort | uniq); do
	head -1 output/AT_CG.csv > output/feature_specific/${${y:gs/\(/}:gs/\)/}.csv
	for x in output/[A,G]*; do
		cat $x | grep $y >> "output/feature_specific/${${y:gs/\(/}:gs/\)/}.csv"
	done
done
```

For the most part, the differences between the betas appear to be distributed around 0, though there are some examples of large differences between the beta values.

## Tracking where in the pipeline differences occured

1. Acquisition and Processing of Reference Data
   * Human genome lengths
   