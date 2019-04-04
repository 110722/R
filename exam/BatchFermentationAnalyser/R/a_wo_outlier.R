#' a_wo_outlier
#'
#' A list containing dataframes.
#'
#'  @format
#'  A list of 8 dataframes with NA values.
#'
#'  @name
#'  a_wo_outlier
NULL


# readBatchDatasets <- function(x) {
#   mylist <- vector(mode = "list", length = length(x))
#   e = 1
#   for (i in x) {
#     mylist[[e]] <- read.table(i,
#                               header = TRUE,
#                               colClasses = "numeric")
#     e = e + 1
#   }
#   return(mylist)
# }
# 
# removeOutliers <- function(x, na.rm = TRUE) {
#   for (i in 1:length(x)) {
#     for (e in 1:ncol(x[[1]])) {
#       q <- quantile(t(x[[i]][, e]), probs = c(0.25, 0.75), na.rm = na.rm)
#       d <- 1.5 * IQR(x[[i]][, e], na.rm = na.rm)
#       x[[i]][, e][x[[i]][, e] < (q[1] - d)] <- NA
#       x[[i]][, e][x[[i]][, e] > (q[2] + d)] <- NA
#     }
#   }
#   return(x)
# }
# 
# basis_dir <- getwd()
# a <- paste(basis_dir, "/inst/extdata/A/A", 1:8, ".txt", sep="")
# a_d <- readBatchDatasets(a)
# a_wo_outlier <- removeOutliers(a_d)
# save(file="data/a_wo_outlier.rda", list="a_wo_outlier")


