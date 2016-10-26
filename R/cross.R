#' The P. virgatum GxE 4-way cross object
#'
#' A dataset containing the R/qtl cross object. It includes the following
#' \itemize{
#'   \item The genotype matrix, where markers have been culled using
#'   qtlTools::repPickMarkerSubset to choose the best markers that are
#'   <1cM apart.
#'   \item The conditional genotype probabilities calculated with a step
#'   of 1 and a stepwidth function of max. Error probability here and elsewhere
#'   is set at 0.001 and the map function is "kosambi"
#'   \item The imputed genotypes with the same parameters as the conditional
#'   genotype probabilities and 64 draws.
#' }
#' @docType data
#' @usage data(cross)
#'
#'
#' @format A R/qtl cross object with 392 individual and 744 markers.
"cross"
