#' @title Merge phenotype data with cross
#'
#' @description
#' \code{mergeCross} Stack cross object (if more than one observation is
#' supplied per 4-way ID) and add phenotypes.
#'
#' @param dat The dataframe containing plant phenotype information. Must be
#' generated by pvGxE.dataLoad
#' @param phenos Character vector indicating the phenotype column names of interest
#' @param verbose Logical, should updates be reported?
#' @export
mergeCross <- function(dat, phenos = NULL, verbose = TRUE){
  if(verbose) cat("loading the cross object\n")
  data(cross)
  ids<-getid(cross)
  if(verbose) cat("merging phenotype data into the cross object\n")
  dat<-dat[dat$LINE %in% ids,]
  if(!is.null(phenos)){
    phenos<-colnames(dat)[-c(1:11)]
    good<-apply(dat[,phenos],1, function(x) !all(is.na(x)))
    dat<-dat[good,c(1:11, which(colnames(dat) %in% phenos))]
  }
  tosub<-match(dat$LINE, pull.pheno(cross)[,"ID"])
  cross2<-subset(cross, ind = tosub)
  cross2$pheno<-data.frame(cross2$pheno, dat)
  return(cross2)
}
