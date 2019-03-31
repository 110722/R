#' saveCarbonBalance
#'
#' @param a dataframe
#' @param a path
#'
#' @return a .csv
#' @export
#'
#' @examples
#'


saveCarbonBalance <- function(x,y) {
  write.table(x,
              file = y,
              col.names= colnames(x),
              quote= F,
              sep=",",
              dec=".",
              row.names= rownames(x))
}
