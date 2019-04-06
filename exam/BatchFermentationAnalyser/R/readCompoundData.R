#' readCompoundData
#'
#' reads a file containing the compound data
#' @param a file
#'
#' @return x a dataframe
#' @export
#'
#' @examples
#' readCompoundData(c)


readCompoundData <- function(x) {
  mycompounds <- read.table(x)
  return(mycompounds)
}
