plotDistn<-function(mergedData, yColumn, nbins = 30, histFill = "grey50", freeXAxis = F, freeYAxis = T,
                    themeIn = theme_jtlbar, nrows = 3){
  parents<-c("AP13", "DAC", "AxD", "WBC", "VS16", "VxW")
  cols<-c("royalblue4","cornflowerblue","cyan","darkred","red","salmon")
  pchs<-c(15,16,17,15,16,17)
  mergedData<-mergedData[!is.na(mergedData[,yColumn]),]
  parentData <- mergedData[mergedData$LINE %in% parents,]
  parentData<-parentData[!is.na(parentData[,yColumn]),]
  parentMeans<-getLineSiteMeans(dat = parentData, y = yColumn)
  mapData <- mergedData[!mergedData$LINE %in% parents,]
  parentMeans$SITE<-factor(parentMeans$SITE)

  if(freeYAxis){
    ywt<-sapply(levels(parentMeans$SITE), function(x)
      (max(hist(mapData[,yColumn][mapData$SITE==x], breaks = nbins, plot=F)$counts))+100)*-.05
    ywt<-data.frame(ywt, SITE = names(ywt))
    parentMeans<-merge(parentMeans, ywt, by = "SITE")
  }else{
    ywt<-max(sapply(levels(parentMeans$SITE), function(x)
      (max(hist(mapData[,yColumn][mapData$SITE==x], breaks = nbins, plot=F)$counts))*-.2))
    parentMeans$ywt<-ywt
  }

  mapData$ywt<-NA
  mapData$SITE<-factor(mapData$SITE, levels = levels(parentMeans$SITE))
  tp<-parentMeans
  tp[,yColumn]<-tp$mean
  mapData$sem <- NA
  tp$mean<-NULL
  for(i in colnames(mapData)[-which(colnames(mapData) %in% colnames(tp))]) tp[,i]<-NA
  tp<-rbind(tp[,colnames(mapData)],mapData)
  tp$lowci<-tp[,yColumn]-tp$sem
  tp$hici<-tp[,yColumn]+tp$sem
  tp$LINE<-factor(tp$LINE, levels = parents)

  if(freeXAxis & freeYAxis){
    scalesInput <- "free"
  }else{
    if(freeYAxis){
      scalesInput <- "free_y"
    }else{
      if(freeYAxis){
        scalesInput <- "free_x"
      }else{
        scalesInput <- "fixed"
      }
    }
  }

  print(
    ggplot(tp, aes_string(x = yColumn))+
      geom_histogram(bins = 30, fill = "grey50")+
      geom_segment(data = tp[!is.na(tp$sem),],
                   aes(y = ywt, yend = ywt,
                       x = lowci, xend = hici),
                   color = "grey50")+
      geom_point(data = tp[!is.na(tp$sem),],
                 aes(color = LINE, shape = LINE, y = ywt))+
      facet_wrap(~SITE, scales = scalesInput, nrow=nrows)+
      scale_color_manual(values = cols)+
      scale_shape_manual(values = pchs)+
      themeIn()
  )

}
