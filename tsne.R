#-----------------------------------------------------------------------------------
# tSNE analysis
#                                                                     
# Martin Sill
# m.sill@dkfz.de                                                                  
# 
# Note, here tSNE is performed on the principal components (PCs) calculated via the singular value decompostion (SVD) of the beta methylation matrix and not
# as described in the paper via the eigenvalue decomposition covariance variance matrix of the beta matrix.
# However, results are comparable.
#
# 2018-03-14 UTC
#------------------------------------------------------------------------------------                   
#options(max.print = 1000)
#options(stringsAsFactors = FALSE)
#options(scipen = 999)
rm(list=ls())

library(Rtsne)
library(RSpectra)

source("R/RSpectra_pca.R")

message("loading preprocessed data ...",Sys.time())
load("./results/betas.ba.RData")

# methylation classed
y <- as.factor(anno$`methylation class:ch1`)

# sd pre filtering to 32k probes
betas <- betas[,order(-apply(betas,2,sd))[1:32000]]

# calculate first 94 PCs
pca <- prcomp_svds(betas,k=94)

# calculate tSNE
res <- Rtsne(pca$x,pca=F,max_iter=2500,theta=0,verbose=T)

# scatterplot tSNE
plot(res$Y,pch=19,col=y)
