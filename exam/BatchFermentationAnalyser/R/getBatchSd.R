#' getBatchSd
#'
#' @param a list of dataframes
#' @param na.rm
#'
#' @return a dataframe
#' @export
#'
#' @examples
#'

getTestSd <- function(x, na.rm = T) {
  for (i in 1:length(x)) {
    x[[i]] <- apply(x[[i]], 2, sd, na.rm = na.rm)
  }
  return(x)
}


getBatchSd <- function(x, na.rm =T){
  test <- getTestSd(x)
  test2 <- t(data.frame(test))
  rownames(test2) <- NULL
  test2 <- as.data.frame(test2)
  x_means <- getBatchMeans(x)
  rownames(test2) <- rownames(x_means)
  test2$hour <- NULL
  return(test2)
}
