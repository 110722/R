#' saveCarbonBalance
#'
#' Function to save a dataframe as a csv, sep="," and dec="."
#' @param a dataframe
#' @param a path
#'
#' @return a .csv
#' @export
#'
#' @examples
#' saveCarbonBalance(a_carbon_balance, paste(output_dir, "a_carbon_balance.csv", sep = ""))


saveCarbonBalance <- function(x,y) {
  write.table(x,
              file = y,
              col.names= colnames(x),
              quote= F,
              sep=",",
              dec=".",
              row.names= rownames(x))
}
