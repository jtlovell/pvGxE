#' @title Get genotype*site means.
#'
#' @description
#' \code{getLineSiteMeans} Sub routine to get line means for the pvGxE Experiment
#'
#' @param dat The dataframe containing parental data
#' @param y Character vector indicating the single response variable
#' Only 1 phenotype can be tested at a time.
#' @export
getLineSiteMeans<-function(dat, y){
  sem<-function(a) sd(as.numeric(a), na.rm = TRUE)/sqrt(sum(!is.na(as.numeric(a))))
  m<-function(a) mean(as.numeric(a), na.rm = TRUE)

  am<-aggregate(dat[,y], dat[,c("SITE", "LINE")], m)
  as<-aggregate(dat[,y], dat[,c("SITE", "LINE")], sem)
  colnames(am)[which(colnames(am)=="x")]<-"mean"
  colnames(as)[which(colnames(as)=="x")]<-"sem"
  return(merge(as,am, by=c("SITE", "LINE")))
}
