#' getBatchSd
#'
#' takes a list of dataframes containing batch information and time
#' and returns one dataframe with the standard deviations
#' of these data, sorted by hour
#' @param x a list of dataframes
#' @param na.rm indicator of missingness
#'
#' @return dataframe
#' @export
#'
#' @examples
#' getBatchSd(a_wo_outlier)

getBatchSd <- function(x, na.rm =TRUE){
  test <- getTestSd(x)
  test2 <- t(data.frame(test))
  rownames(test2) <- NULL
  test2 <- as.data.frame(test2)
  x_means <- getBatchMeans(x)
  rownames(test2) <- rownames(x_means)
  test2$hour <- NULL
  return(test2)
}
