
#' @import qtl
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
