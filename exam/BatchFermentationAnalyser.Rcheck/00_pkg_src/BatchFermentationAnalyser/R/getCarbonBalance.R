#' getCarbonBalance
#'
#' Calculates the Carbon Balance. Needs a list of dataframes, containing batch
#' data, and a dataframe with information about molweight and carbons of the
#' substances. CAUTION: names have to be the same.
#' cumulate = "co2" per default - values get cumulated.
#' @param list of dataframes
#' @param dataframe
#' @param cumulate
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' getCarbonBalance(a_wo_outlier, a_cd, cumulate="co2")


getCarbonBalance <- function(x,y,cumulate ="co2"){
  x_m <- getBatchMeans(x)
  x_m[cumulate] <- cumsum(x_m[cumulate])
  for (i in colnames(x_m)){
    x_m[,i] <- ((x_m[, i] / y[i, "molweight"]) * y[i, "carbons"])
  }
  return(x_m)
}
