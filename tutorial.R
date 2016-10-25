###
# The pipe to run statistical analysis of P. virgatum GxE
# All that is needed is a csv file that contains some response data and a
# column with the "PLOT_GL" for each observation. This column must be titled
# "PLOT_GL"
# All response data MUST be numeric - character data will be converted to NAs

dat<-pvGxE.dataLoad(csv = "testPhenos.csv", directory = "./data")
plotDistn(mergedData=dat, yColumn = "EMER50", nbins = 50,
          nrow = 5, freeYAxis=F, themeIn = theme_jtl)
