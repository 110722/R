#' removeOutliers
#'
#' gets a list of dataframes and identifies outliers by boxplots and IQRs.
#' outliers get replaced with NA
#' @param a list of dataframes
#' @param na.rm
#'
#' @return a list of dataframes
#' @export
#'
#' @examples
#' removeOutliers(a_d)


removeOutliers <- function(x, na.rm = TRUE) {
  for (i in 1:length(x)) {
    for (e in 1:ncol(x[[1]])) {
      q <- quantile(t(x[[i]][, e]), probs = c(0.25, 0.75), na.rm = na.rm)
      d <- 1.5 * IQR(x[[i]][, e], na.rm = na.rm)
      x[[i]][, e][x[[i]][, e] < (q[1] - d)] <- NA
      x[[i]][, e][x[[i]][, e] > (q[2] + d)] <- NA
    }
  }
  return(x)
}
