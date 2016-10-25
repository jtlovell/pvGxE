#' @title Import data for pvGxE
#'
#' @description
#' \code{pvGxE.dataLoad} Function to load user-supplied data into R.
#'
#' @param csv The name of the csv file.
#' @param directory The location of the csv.
#' @import qtl
#' @export
pvGxE.dataLoad<-function(csv, directory = NULL){

  library(devtools)
  install_github("jtlovell/pvGxE", quiet = TRUE)
  install_github("jtlovell/qtlTools", quiet = TRUE)
  library(pvGxE)
  library(qtlTools)

  if(is.null(directory)){
    file = paste(getwd(),csv, sep = "/")
  }else{
    file = paste(directory, csv, sep = "/")
  }
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
  for(i in colnames(out)[-which(colnames(out) %in% colnames(metaData))])
    out[,i]<-as.numeric(out[,i])
  return(out)
}
