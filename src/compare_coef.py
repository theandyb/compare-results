import pandas as pd
import numpy as np
import sys
from os import listdir
from os.path import isfile, join

def main(argv):
    columns = ("Cov", "Estimate", "SE", "Z", "pval", "motif")
    mutant_types = ('AT_CG',  'AT_GC',  'AT_TA',  'GC_AT',  'GC_CG',  'GC_TA')
    
    if(len(argv)<1):
        print("Please provide an integer between 0 and 5 when calling this script")
        sys.exit(2)
    try:
        mut_dir = mutant_types[int(argv[0])]
    except:
        print("Please provide an integer between 0 and 5 when calling this script")
        sys.exit(2)
    
    andy_dir = "/net/snowwhite/home/beckandy/research/smaug-redux/output/logmod_data/coefs/" + mut_dir
    jed_dir = "/net/bipolar/jedidiah/mutation/output/logmod_data/coefs/" + mut_dir

    outfile = "/net/snowwhite/home/beckandy/research/compare_results/output/" + mut_dir + ".csv"
    if not isfile(outfile):
        with open(outfile,'w+') as f:
            f.write("Motif, Var, BetaDiff, SignBeta, PDiff, ABeta, jBeta, AP, JP\n")

    coef_files = [f for f in listdir(andy_dir) if isfile(join(andy_dir, f))]

    for f in coef_files:
        jed_file = join(jed_dir, f)
        andy_file = join(andy_dir, f)

        andy_df = pd.read_csv(andy_file, header = None, names = columns, sep='\t')
        jed_df = pd.read_csv(jed_file, header = None, names = columns, sep='\t')

        motif = "_".join(f.split(".")[0].split("_")[0:3])
        res = pd.DataFrame({'Motif': motif, 
            'Var': andy_df.Cov, 
            'BetaDiff': andy_df.Estimate - jed_df.Estimate, 
            'SignBeta': np.sign(andy_df.Estimate) == np.sign(jed_df.Estimate), 
            'PDiff': andy_df.pval - jed_df.pval,
            'ABeta': andy_df.Estimate,
            'jBeta': jed_df.Estimate,
            'AP':andy_df.pval,
            'JP':jed_df.pval})
        res.SignBeta = res.SignBeta.astype(int)
        with open(outfile, 'a') as f:
            res.to_csv(f, header = False, index = False)
    return(0)

if __name__ == "__main__":
    main(sys.argv[1:])
