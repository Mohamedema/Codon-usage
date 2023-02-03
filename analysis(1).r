## This code is used to make the A one-way ANOVA) and posthoc tests (Fisher's LSD), PCA, sPLSDA, 
## and cluster analysis, on the mean of the MILC of the samples.

library(MetaboAnalystR)

## Initiate and read the data

mSet<-InitDataObjects("conc", "stat", FALSE)
mSet<-Read.TextData(mSet, "Replacing_with_your_file_path", "colu", "disc")

## Sanity quality check

mSet<-SanityCheckData(mSet)

## Replace NAs values with the minimum value (No NAs in our data)

mSet<-ReplaceMin(mSet)

## No Filteration, Normalization, or scaling of the data

mSet<-FilterVariable(mSet, "none", "F", 25)
mSet<-PreparePrenormData(mSet)
mSet<-Normalization(mSet, "NULL", "NULL", "NULL", ratio=FALSE, ratioNum=20)

## ANOVA analysis

mSet<-ANOVA.Anal(mSet, F, 0.05, "fisher", FALSE)

## SPLSDA analysis

mSet<-SPLSR.Anal(mSet, 5, 10, "same", "Mfold")
mSet<-PlotSPLS2DScore(mSet, "spls_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)

## PCA analysis 

mSet<-PCA.Anal(mSet)
mSet<-PlotPCA2DScore(mSet, "pca_score2d_0_", "png", 72, width=NA, 1,2,0.95,0,0)

## Cluster analysis and heatmap generation
mSet<-PlotSubHeatMap(mSet, "heatmap_1_", "png", 72, width=NA, "norm", "row", "euclidean", "ward.D","bwm", 8, "tanova", 20, "overview", T, T, T, F, T, T, T)
