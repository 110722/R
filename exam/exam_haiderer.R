# library(BatchFermentationAnalyser)

setwd("C:/Users/user/Desktop/VM-Zeug/sem2/R/exam")

# FUNCTIONS:

readBatchDatasets <- function(x) {
  mylist <- vector(mode = "list", length = length(x))
  e = 1
  for (i in x) {
    mylist[[e]] <- read.table(i,
                              header = TRUE,
                              colClasses = "numeric")
    e = e + 1
  }
  return(mylist)
}


readCompoundData <- function(x) {
  mycompounds <- read.table(x)
  return(mycompounds)
}



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


##########################################

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
  return(test2)
}

getBatchMeans(a_d)


##########################################


getTestSd <- function(x, na.rm = T) {
  for (i in 1:length(x)) {
    x[[i]] <- apply(x[[i]], 2, sd, na.rm = na.rm)
  }
  return(x)
}


getBatchSd <- function(x, na.rm =T){
  test <- getTestSd(x)
  test2 <- t(data.frame(test))
  rownames(test2) <- NULL
  return(test2)
}




#######################################################
# x = a wo outliers y = a_cd
# return data.frame containing carbon balance information
# for each timepoint



#######################################################
# eine Zeile (für Co2)
# ich hab zum zeitpunkt 0.4 h -> 0.138 g Co2 -> 13.7 hab ich cumsum 7g Co2
# Co2 is 44.01 g/mol 
# also hab ich zum zeitpunkt 0.4 -> 0.138g / 44.01 g/mol = 0.003136 mol Co2
# zum zeitpunkt 13.7h -> cumsum(position2) / 44.01 g/mol = 0.159 mol Co2
#######################################################
# beispiel glucose:
# 0.4 -> 32.67g   --> 32.67/ 180.18 = 0.1813 mol * 6 Carbon= 1.087 
# 13.07h -> 22.25g --> 22.25/ 180.18* 6= 0.74 das muss in tabelle
#######################################################
# letzte Zeile Carbonsum= sum über ganze spalte
#######################################################



# warum geht das mit print so gut und mit return geht nix

cumulate= "co2"
mytestlist <- list()
for (i in colnames(a_means)){
  if (i == cumulate){
    x_balance <- cumsum(((a_means[,i]/a_cd[i,"molweight"]) * a_cd[i,"carbons"]))}
  else {
  x_balance <- as.numeric(((a_means[,i]/a_cd[i,"molweight"]) * a_cd[i,"carbons"]))
  }
  mytestlist <- append(mytestlist, as.numeric(x_balance))
}
?append
str(mytestlist)
#mysecondtestlist <- unlist(mytestlist)
#str(mysecondtestlist)
mymatrix <- matrix(mytestlist, ncol=ncol(a_means), nrow=nrow(a_means))

mydf <- as.data.frame(t(mymatrix), stringsAsFactors = F)
rownames(mydf) <- colnames(a_means)
mydf <- mydf[-1,]
colnames(mydf) <- a_means[,"hour"]

# carbonsum Zeile anfügen
summi <- list()
for (i in colnames(mydf)) {
summi[i] <- sum(unlist(mydf[,i]))
}
str(summi)

mydf[nrow(mydf)+1,] <- summi
rownames(mydf)[nrow(mydf)] <- "carbonsum"

# carbonbalance anfügen:
str(unlist(mydf["carbonsum",1]))
refval <- unlist(mydf["carbonsum",1])
balval <- list()
for (i in colnames(mydf)) {
  balval[i] <- (unlist(mydf["carbonsum",i]))/refval
}
mydf[nrow(mydf)+1,] <- balval
rownames(mydf)[nrow(mydf)] <- "carbonbalance"

#########################################################################

getCarbonBalance <- function(x, y, cumulate="co2"){
  x_means <- getBatchMeans(x)
  mylist <- list()  #TODO: length !
  for (i in colnames(x_means)){
    if (i == cumulate){
      x_balance <- cumsum(((x_means[,i]/y[i,"molweight"]) * y[i,"carbons"]))}
    else {
      x_balance <- as.numeric(((x_means[,i]/y[i,"molweight"]) * y[i,"carbons"]))
    }
    mylist <- append(mylist, as.numeric(x_balance))
  }
  mymatrix <- matrix(mylist, ncol=ncol(x_means), nrow=nrow(x_means))
  mydf <- as.data.frame(t(mymatrix), stringsAsFactors = F)
  rownames(mydf) <- colnames(x_means)
  mydf <- mydf[-1,]
  colnames(mydf) <- x_means[,"hour"]
  
  # carbonsum Zeile anfügen
  summi <- list()
  for (i in colnames(mydf)) {
    summi[i] <- sum(unlist(mydf[,i]))
  }
  mydf[nrow(mydf)+1,] <- summi
  rownames(mydf)[nrow(mydf)] <- "carbonsum"
  
  # carbonbalance anfügen:
  str(unlist(mydf["carbonsum",1]))
  refval <- unlist(mydf["carbonsum",1])
  balval <- list()
  for (i in colnames(mydf)) {
    balval[i] <- (unlist(mydf["carbonsum",i]))/refval
  }
  mydf[nrow(mydf)+1,] <- balval
  rownames(mydf)[nrow(mydf)] <- "carbonbalance"
  return(mydf)
}


# warum nimmts mir da nur das letzte???
# getCarbonBalance <- function(x, y, cumulate="co2"){
#   x_means <- getBatchMeans(x)
#   # cs <- cumulate
#   # x_cumsum <- cumsum(x_means[,cs])
#   for (i in colnames(x_means)){
#   x_balance <- ((x_means[,i]/y[i,"molweight"]) * y[i,"carbons"])
#   test <- cbind(c(x_means[,"hour"]), x_balance)
#   }
#   return(test)
# }

isesdas <- getCarbonBalance(a_wo_outlier,a_cd,cumulate="co2")

##############################################
?cbind
?setNames




basis_dir <- getwd()
input_dir <- paste(basis_dir, "/input/", sep = "")
output_dir <- paste(basis_dir, "/output/", sep = "")
a <- paste(input_dir, "A/A", 1:8, ".txt", sep="")
a_d <- readBatchDatasets(a)
a_cd <- readCompoundData(paste(input_dir, "A/Compounds.txt", sep = ""))
a_wo_outlier <- removeOutliers(a_d)
a_means <- getBatchMeans(a_wo_outlier)
a_sd <- getBatchSd(a_wo_outlier)
# a_carbon_balance <- getCarbonBalance(a_wo_outlier, a_cd, cumulate="co2")
# saveCarbonBalance(a_carbon_balance, paste(output_dir, "a_carbon_balance.csv", sep = ""))
# plot_fermdata(a_wo_outlier, cumulate="co2")
# plot_fermdata(a_wo_outlier, cumulate="co2", type = "png",
#               filename = paste(output_dir, "a.png", sep = ""), width = 1200,
#               height = 800)
#
b <- paste(input_dir, "B/B", 1:8, ".txt", sep="")
b_d <- readBatchDatasets(b)
b_cd <- readCompoundData(paste(input_dir, "B/Compounds.txt", sep = ""))
b_wo_outlier <- removeOutliers(b_d)
b_means <- getBatchMeans(b_wo_outlier)
b_sd <- getBatchSd(b_wo_outlier)
# b_carbon_balance <- getCarbonBalance(b_wo_outlier, b_cd, cumulate="co2")
# saveCarbonBalance(b_carbon_balance, paste(output_dir, "b_carbon_balance.csv", sep = ""))
# plot_fermdata(b_wo_outlier, cumulate="co2")
# plot_fermdata(b_wo_outlier, cumulate="co2", type = "jpeg",
#               filename = paste(output_dir, "b.jpg", sep = ""), width = 1600,
#               height = 1000, res = 120)
