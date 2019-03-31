#' getBatchMeans
#'
#' @param a list of dataframes
#' @param na.rm
#'
#' @return a dataframe
#' @export
#'
#' @examples
#'
#'

getTestMeans <- function(x, na.rm = T) {
  for (i in 1:length(x)) {
    x[[i]] <- apply(x[[i]], 2, mean, na.rm = na.rm)
  }
  return(x)
}


getBatchMeans <- function(x, na.rm =T){
  test <- getTestMeans(x)
  test2 <- t(data.frame(test))
  rownames(test2) <- NULL
  test2 <- as.data.frame(test2)
  rownames(test2) <- unlist(test2$hour)
  test2$hour <- NULL
  return(test2)
}
