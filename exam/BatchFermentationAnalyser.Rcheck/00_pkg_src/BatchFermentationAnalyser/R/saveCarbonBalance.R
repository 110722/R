#' saveCarbonBalance
#'
#' Function to save a dataframe as a csv, sep="," and dec="."
#' @param x a dataframe
#' @param y a path
#'
#' @return a .csv
#' @export
#'
#' @examples
#' saveCarbonBalance(a_carbon_balance, "a_carbon_balance.csv")


saveCarbonBalance <- function(x,y) {
  write.table(x,
              file = y,
              col.names= colnames(x),
              quote= F,
              sep=",",
              dec=".",
              row.names= rownames(x))
}
