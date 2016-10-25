#' @title Import data for pvGxE
#'
#' @description
#' \code{combineDatasets} Function to combine separate user-specified datasets
#'
#' @param directory The location of the csvs.
#' @param lookFor The character string to look for in the directory. Defaults
#' to ".csv"
#' @param verbose Should updates on progress be printed?
#' @export
combineDatasets<-function(directory, lookFor = ".csv", verbose=T){
  files<- list.files(directory, pattern = lookFor)

  if(verbose) cat("installing and loading required libraries\n")
  library(devtools)
  install_github("jtlovell/pvGxE", quiet = TRUE)
  install_github("jtlovell/qtlTools", quiet = TRUE)
  library(pvGxE)
  library(qtlTools)

  if(verbose) cat("getting data from the following files:\n",
                  paste(files, collapse = ", "))

  dataLoad<-function(x){
    file = paste(directory, x, sep = "/")
    dat <- read.csv(file, header = T, stringsAsFactors = F)

    data(metaData)
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
    suppressWarnings(
      for(i in colnames(out)[-which(colnames(out) %in% colnames(metaData))])
        out[,i]<-as.numeric(out[,i])
    )
    return(out)
  }
  dat<-lapply(files, dataLoad)
  allnames<-unique(unlist(lapply(dat, colnames)))
  dat<-lapply(dat, function(x){
    if(!all(colnames(x) %in% allnames)){
      for(i in colnames(x)[!colnames(x) %in% allnames]){
        x[,i]<-NA
      }
    }
    x<-x[,allnames]
    return(x)
  })
  dat<-do.call(rbind, dat)
  return(dat)
}
