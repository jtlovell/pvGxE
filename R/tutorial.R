dat<-pvGxE.dataLoad(csv = "testPhenos.csv", directory = "./data")
plotDistn(mergedData=dat, yColumn = "EMER50", nrow = 5, freeYAxis=F)

parentData <- mergedData[mergedData$LINE %in% parents,]
mapData <- mergedData[!mergedData$LINE %in% parents,]
