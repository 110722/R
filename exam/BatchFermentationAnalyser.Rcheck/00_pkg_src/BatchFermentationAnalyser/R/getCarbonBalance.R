#' getCarbonBalance
#'
#' Calculates the Carbon Balance. Needs a list of dataframes, containing batch
#' data, and a dataframe with information about molweight and carbons of the
#' substances. CAUTION: names have to be the same.
#' cumulate = "co2" per default - values get cumulated.
#' @param x a list of dataframes
#' @param y a dataframe
#' @param cumulate a column name
#'
#' @return a dataframe
#' @export
#'
#' @examples
#' getCarbonBalance(a_wo_outlier, a_cd, cumulate="co2")


getCarbonBalance <- function(x, y, cumulate = "co2") {
  x_m <- getBatchMeans(x)
  z <- colnames(x_m)
  y <- y[z, ]
  x_m[, cumulate] <- cumsum(x_m[, cumulate])
  for (i in 1:ncol(x_m)) {
    for (j in 1:nrow(x_m)) {
      x_m[j, i] <- ((x_m[j, i] / y[i, "molweight"]) * y[i, "carbons"])
    }
  }
  len <- ncol(x_m)
  x_m[, len + 1] <- rowSums(x_m)
  colnames(x_m)[len + 1] <- "carbonsum"

  len2 <- ncol(x_m)
  refval <- x_m[1,"carbonsum"]
  for (i in 1:len2){
    x_m[i, (len2 + 1)] <- ((x_m[i,"carbonsum"])/refval)
  }
  colnames(x_m)[len2 + 1] <- "carbonbalance"
  zeil <- nrow(x_m)
  x_m <- x_m[-zeil,]
  x_m <- as.data.frame(t(x_m))
  return(x_m)
}
