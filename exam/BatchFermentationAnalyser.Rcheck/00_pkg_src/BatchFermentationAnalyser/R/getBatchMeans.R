#' getBatchMeans
#'
#' takes a list of dataframes containing batch information and time
#' and returns one dataframe of the Means of these data, sorted by hour
#' @param list of dataframes
#' @param na.rm
#'
#' @return dataframe with batch-means
#' @export
#'
#' @examples
#' getBatchMeans(a_wo_outlier)

getBatchMeans <- function(x, na.rm =TRUE){
  test <- getTestMeans(x)
  test2 <- t(data.frame(test))
  rownames(test2) <- NULL
  test2 <- as.data.frame(test2)
  rownames(test2) <- unlist(test2$hour)
  test2$hour <- NULL
  return(test2)
}
