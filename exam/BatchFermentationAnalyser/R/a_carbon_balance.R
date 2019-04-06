#' a_carbon_balance
#'
#' A dataframe with CarbonBalance Data.
#'
#'  @format
#'  A dataframe.
#'
#'  @name
#'  a_Carbon_balance
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
#
# readCompoundData <- function(x) {
#   mycompounds <- read.table(x)
#   return(mycompounds)
# }
#
#
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
#
# ##########################################
#
# getTestMeans <- function(x, na.rm = T) {
#   for (i in 1:length(x)) {
#     x[[i]] <- apply(x[[i]], 2, mean, na.rm = na.rm)
#   }
#   return(x)
# }
#
#
# getBatchMeans <- function(x, na.rm =T){
#   test <- getTestMeans(x)
#   test2 <- t(data.frame(test))
#   rownames(test2) <- NULL
#   test2 <- as.data.frame(test2)
#   rownames(test2) <- unlist(test2$hour)
#   test2$hour <- NULL
#   return(test2)
# }
#
#
# getCarbonBalance <- function(x, y, cumulate = "co2") {
#   x_m <- getBatchMeans(x)
#   z <- colnames(x_m)
#   y <- y[z, ]
#   x_m[, cumulate] <- cumsum(x_m[, cumulate])
#   for (i in 1:ncol(x_m)) {
#     for (j in 1:nrow(x_m)) {
#       x_m[j, i] <- ((x_m[j, i] / y[i, "molweight"]) * y[i, "carbons"])
#     }
#   }
#   len <- ncol(x_m)
#   x_m[, len + 1] <- rowSums(x_m)
#   colnames(x_m)[len + 1] <- "carbonsum"
#
#   len2 <- ncol(x_m)
#   refval <- x_m[1,"carbonsum"]
#   for (i in 1:len2){
#     x_m[i, (len2 + 1)] <- ((x_m[i,"carbonsum"])/refval)
#   }
#   colnames(x_m)[len2 + 1] <- "carbonbalance"
#   zeil <- nrow(x_m)
#   x_m <- x_m[-zeil,]
#   x_m <- as.data.frame(t(x_m))
#   return(x_m)
# }
#
#
#
#
#
#
# basis_dir <- getwd()
# basis_dir
# a <- paste(basis_dir, "/inst/extdata/A/A", 1:8, ".txt", sep="")
# a_d <- readBatchDatasets(a)
# c <- paste(basis_dir, "/inst/extdata/A/Compounds.txt", sep="")
# a_cd <- readCompoundData(c)
# a_wo_outlier <- removeOutliers(a_d)
# a_carbon_balance <- getCarbonBalance(a_wo_outlier, a_cd, cumulate="co2")
# save(file="data/a_carbon_balance.rda", list="a_carbon_balance")
