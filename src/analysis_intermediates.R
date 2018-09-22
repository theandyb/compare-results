require(devtools)
install_github('theandyb/smaug', quiet=TRUE)
require(smaug)

args = commandArgs(trailingOnly=TRUE)

packages <- c("tidyverse", "broom", "RColorBrewer", "MASS", "boot", "speedglm",
                "psych", "lmtest", "fmsb", "hexbin", "cowplot", "grid", "gtable", "gridExtra",
                        "yaml", "openxlsx", "Biostrings", "svglite", "NMF", "emdbook")
invisible(sapply(packages, function(x)
                        suppressMessages(usePackage(x))))

# Define additional variables for cleaner strings, etc.
adj <- 4
binw <- 1000000
bink <- binw/1000
nbp <- adj*2+1
data <- "full"
mac <- "singletons"

if(args[1] == "andy"){
        parent.dir <- "/net/snowwhite/home/beckandy/research/smaug-redux"
} else {
        parent.dir <- "/net/bipolar/jedidiah/mutation"
}

datadir <- paste0(parent.dir, "/output/", nbp, "bp_", bink, "k_singletons_", data)
summfile <- paste0(parent.dir, "/summaries/", mac, ".", data, ".summary")
singfile <- paste0(parent.dir, "/singletons/full.singletons")
bindir <- paste0(parent.dir, "/motif_counts/", nbp, "-mers/full")


## Step 1: read and pre-process data
analysisdir <- parent.dir
full_data <- getData(summfile, singfile, bindir)
# Save intermediate results to files
saveRDS(full_data$sites, file = paste0("intermediate/",args[1],".sites.rds")
saveRDS(full_data$bins, file = paste0("intermediate/",args[1],".bins.rds")
saveRDS(full_data$mct, file = paste0("intermediate/",args[1],".mct.rds")
