# Get data
getData<-function(csv, directory = NULL){
  if(is.null(directory)){
    file = paste(getwd(),csv, sep = "/")
  }else{
    file = paste(directory, csv, sep = "/")
  }
  dat <- read.csv(file, header = T, stringsAsFactors = F)
  return(dat)
}

# Merge with meta data
mergeMeta<-function(dat, metaData){
  if(!"PLOT_GL" %in% colnames(dat))
    stop("input data must have a PLOT_GL column\n")
  if(!any(dat$PLOT_GL %in% metaData$PLOT_GL)){
    bads<-which(!dat$PLOT_GL %in% metaData$PLOT_GL)
    bads<-dat$PLOT_GL[bads]
    warning(paste0("PLOT_GL IDs not in the metadata: ",
                   paste(PLOT_GL, collapse = ", "),
                   "\n these samples will be ignored"))
  }
  out<-merge(metaData, dat, by = "PLOT_GL")
  return(out)
}

pvGxE.dataLoad<-function(csv, directory = NULL){
  dat<-getData(csv, directory = directory)
  data(metaData)
  out<-mergeMeta(dat=dat, metaData=metaData)
  return(out)
}
