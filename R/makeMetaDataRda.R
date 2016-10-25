metaData<-read.csv("./data/pvGxE_metadata.csv", header=T, stringsAsFactors = F)
save(metaData, file = "metaData.rda")
