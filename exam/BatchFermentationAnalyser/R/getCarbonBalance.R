#' getCarbonBalance
#'
#' @param a list of dataframes
#' @param a dataframe
#' @param cumulate
#'
#' @return a dataframe
#' @export
#'
#' @examples
#'


getCarbonBalance <- function(x,y,cumulate ="co2"){
  x_m <- getBatchMeans(x)
  x_m[cumulate] <- cumsum(x_m[cumulate])
  for (i in ncol(x_m)){
    x_m[,i] <- ((x_m[, i] / y[i, "molweight"]) * y[i, "carbons"])
  }
  return(x_m)
}
