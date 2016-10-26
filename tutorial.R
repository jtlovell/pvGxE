###
# The pipe to run statistical analysis of P. virgatum GxE
# All that is needed is a csv file that contains some response data and a
# column with the "PLOT_GL" for each observation. This column must be titled
# "PLOT_GL"
# All response data MUST be numeric - character data will be converted to NAs

library(devtools)
install_github("jtlovell/pvGxE", quiet = TRUE)
install_github("jtlovell/qtlTools", quiet = TRUE)
library(qtlTools)
library(pvGxE)

dat<-pvGxE.dataLoad(csv = "testPhenos.csv", directory = "./data")
plotDistn(mergedData=dat, yColumn = "EMER50", nbins = 50,
          nrow = 5, freeYAxis=F, themeIn = theme_jtl)

# split up the example data so that it can be combined
system("mkdir ./data/sepfiles")
for(i in unique(substr(dat$PLOT_GL,1,1))){
  temp<-dat[substr(dat$PLOT_GL,1,1) == i,]
  write.csv(temp, file = paste0("./data/sepfiles/",i,".csv"), row.names=F)
}

dat2<-combineDatasets(directory = "./data/sepfiles")
identical(dat2, dat)

cross <- read.cross("csvr", , "~/Downloads/NSF_4WCR_Milano_rQTL_InputFile.csv",
                    genotypes=NULL, alleles=c("A", "B", "C", "D"))
cross <- repPickMarkerSubset(cross, min.distance = 1)
cross <- calc.genoprob(cross, step = 1, stepwidth = "max",
                       error.prob = 0.001, map.function = "kosambi")
cross <- sim.geno(cross, step = 1, stepwidth = "max", n.draws = 64,
                       error.prob = 0.001, map.function = "kosambi")
cross<-subset(cross, ind = order(pull.pheno(cross)[,1]))
save(cross, file = "./data/cross.rda")

cross2<-mergeCross(dat)
# mergeCross


