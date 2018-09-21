require(devtools)
install_github('theandyb/smaug', quiet=TRUE)
require(smaug)

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

andy <- list(parent.dir = "/net/snowwhite/home/beckandy/research/smaug-redux")
jed <- list(parent.dir = "/net/bipolar/jedidiah/mutation")

andy$datadir <- paste0(andy$parent.dir, "/output/", nbp, "bp_", bink, "k_singletons_", data)
andy$summfile <- paste0(andy$parent.dir, "/summaries/", mac, ".", data, ".summary")
andy$singfile <- paste0(andy$parent.dir, "/singletons/full.singletons")
andy$bindir <- paste0(andy$parent.dir, "/motif_counts/", nbp, "-mers/full")

jed$datadir <- paste0(jed$parent.dir, "/output/", nbp, "bp_", bink, "k_singletons_", data)
jed$summfile <- paste0(jed$parent.dir, "/summaries/", mac, ".", data, ".summary")
jed$singfile <- paste0(jed$parent.dir, "/singletons/full.singletons")
jed$bindir <- paste0(jed$parent.dir, "/motif_counts/", nbp, "-mers/full")


## Step 1: read and pre-process data
analysisdir <- andy$parent.dir
andy$full_data <- getData(andy$summfile, andy$singfile, andy$bindir)
# Save intermediate results to files
saveRDS(andy$full_data$sites, file = "intermediate/andy.sites.rds")
saveRDS(andy$full_data$bins, file = "intermediate/andy.bins.rds")
saveRDS(andy$full_data$mct, file = "intermediate/andy.mct.rds")
andy$full_data <- NULL

analysisdir <- jed$parent.dir
jed$full_data <- getData(jed$summfile, jed$singfile, jed$bindir)
saveRDS(jed$full_data$sites, file = "intermediate/jed.sites.rds")
saveRDS(jed$full_data$bins, file = "intermediate/jed.bins.rds")
saveRDS(jed$full_data$mct, file = "intermediate/jed.mct.rds")
jed$full_data <- NULL