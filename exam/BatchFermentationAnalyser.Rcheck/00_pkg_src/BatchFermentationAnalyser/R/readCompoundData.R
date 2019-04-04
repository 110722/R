#' readCompoundData
#'
#' reads a file containing the compound data
#' @param a file
#'
#' @return x a dataframe
#' @export
#'
#' @examples
#' readCompoundData("inst/extdata/A/Compounds.txt")


readCompoundData <- function(x) {
  mycompounds <- read.table(x)
  return(mycompounds)
}
