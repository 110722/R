#' getTestMeans
#'
#' Auxiliary Function for getBatchMeans.
#' @param list of dataframes
#' @param na.rm
#'
#' @return dataframe
#' @export
#'
#' @examples
#' getTestMeans(a_wo_outlier)
#'

getTestMeans <- function(x, na.rm = TRUE) {
  for (i in 1:length(x)) {
    x[[i]] <- apply(x[[i]], 2, mean, na.rm = na.rm)
  }
  return(x)
}


