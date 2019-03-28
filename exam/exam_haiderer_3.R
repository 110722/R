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
  test2 <- as.data.frame(test2)
  rownames(test2) <- unlist(test2$hour)
  test2$hour <- NULL
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
  test2 <- as.data.frame(test2)
  x_means <- getBatchMeans(x)
  rownames(test2) <- rownames(x_means)
  test2$hour <- NULL
  return(test2)
}




#######################################################
###todo:
#carbonbalance

    


getCarbonBalance <- function(x, y, cumulate = "co2") {
  x_means <- getBatchMeans(x)
  mylist <- list()
  for (i in colnames(x_means)) {
    if (i == cumulate) {
      x_balance <-
        cumsum(((x_means[, i] / y[i, "molweight"]) * y[i, "carbons"]))
    }
    else {
      x_balance <-
        as.numeric(((x_means[, i] / y[i, "molweight"]) * y[i, "carbons"]))
    }
    mylist <- append(mylist, as.numeric(x_balance))
  }
  mymatrix <- matrix(mylist, ncol = ncol(x_means), nrow = nrow(x_means))
  mydf <- as.data.frame(t(mymatrix), stringsAsFactors = F)
  rownames(mydf) <- colnames(x_means)
  mydf <- mydf[-1, ]
  colnames(mydf) <- x_means[, "hour"]
  
  # carbonsum Zeile anfügen
  summi <- list()
  for (i in colnames(mydf)) {
    summi[i] <- sum(unlist(mydf[, i]))
  }
  mydf[nrow(mydf) + 1, ] <- summi
  rownames(mydf)[nrow(mydf)] <- "carbonsum"
  
  # carbonbalance anfügen:
  str(unlist(mydf["carbonsum", 1]))
  refval <- unlist(mydf["carbonsum", 1])
  balval <- list()
  for (i in colnames(mydf)) {
    balval[i] <- (unlist(mydf["carbonsum", i])) / refval
  }
  mydf[nrow(mydf) + 1, ] <- balval
  rownames(mydf)[nrow(mydf)] <- "carbonbalance"
  for (i in 1:ncol(mydf)){
    mydf[,i] <- unlist(mydf[,i])
  }
  return(mydf)
}




##############################################

saveCarbonBalance <- function(x,y) {
              write.table(x,
                          file = y,
                          col.names= colnames(x),
                          quote= F,
                          sep=",",
                          dec=".",
                          row.names= rownames(x))
}


###############################################
# plot_fermdata(a_wo_outlier, cumulate="co2")

# x_Achse: hour
# y_Achse: gramm (a_means/a_sd pfeile)
originalpar <- par()
plot(rownames(b_means), b_means$glucose)


str(a_means)


###########################################



only_plot_fermdata <- function(x, cumulate="co2", cex=0.5){
  x_means <- getBatchMeans(x)
  x_means[cumulate] <- cumsum(x_means[cumulate]) 
  x_sd <- getBatchSd(x)
  gHigh <- x_means + abs(x_sd)
  gLow <- x_means - abs(x_sd)
  
  plot(rownames(x_means), x_means$glucose,
       type="l", ylab = "[g]", xlab= "hours", las=1, ylim=c(min(gLow), max(gHigh)),
       main="Batch Data")
  cls <- 2:length(colnames(x_means))
  for (i in cls){
  lines(rownames(x_means), x_means[,i], col=i, type="l")
  }
  legend("topright",
         legend= colnames(x_means),
         col= 1:length(colnames(x_means)),
         lwd=1,
         title ="substances",
         horiz=F,
         title.col=1,
         ncol=4,
         cex=cex)
  clrs <- 1:length(colnames(x_means))
  for (i in 1:length(colnames(x_means))){
  arrows((as.numeric(rownames(x_means))), gHigh[,i], (as.numeric(rownames(x_means))), gLow[,i],
         col=clrs[i],
         angle=90,
         length=0.025,
         code=3)
  }
  # export filename, type =type, width=width, height=height
}

plot_fermdata <-
  function(x,
           cumulate = "co2",
           type = NA,
           filename = NA,
           width = 480,
           height = 480,
           res = 72) {
    only_plot_fermdata(x = x, cumulate = cumulate)
    if (!(is.na(type))){
    if (type=="png") {
      cex<-1.5
    png(filename,
           width = width,
           height = height,
           res = res)
      only_plot_fermdata(x = x, cumulate = cumulate, cex=cex)
      dev.off() 
      } 
    if (type=="jpeg"){
      cex<-1.5
      jpeg(filename,
          width = width,
          height = height,
          res = res)
      only_plot_fermdata(x = x, cumulate = cumulate, cex=cex)
      dev.off()
    } else { print("Please choose png or jpeg")}  }

    
    
  }















basis_dir <- getwd()
input_dir <- paste(basis_dir, "/input/", sep = "")
output_dir <- paste(basis_dir, "/output/", sep = "")
a <- paste(input_dir, "A/A", 1:8, ".txt", sep="")
a_d <- readBatchDatasets(a)
a_cd <- readCompoundData(paste(input_dir, "A/Compounds.txt", sep = ""))
a_wo_outlier <- removeOutliers(a_d)
a_means <- getBatchMeans(a_wo_outlier)
a_sd <- getBatchSd(a_wo_outlier)
a_carbon_balance <- getCarbonBalance(a_wo_outlier, a_cd, cumulate="co2")
saveCarbonBalance(a_carbon_balance, paste(output_dir, "a_carbon_balance.csv", sep = ""))
plot_fermdata(a_wo_outlier, cumulate="co2")
plot_fermdata(a_wo_outlier, cumulate="co2", type = "png",
               filename = paste(output_dir, "a.png", sep = ""), width = 1200,
               height = 800)
#
b <- paste(input_dir, "B/B", 1:8, ".txt", sep="")
b_d <- readBatchDatasets(b)
b_cd <- readCompoundData(paste(input_dir, "B/Compounds.txt", sep = ""))
b_wo_outlier <- removeOutliers(b_d)
b_means <- getBatchMeans(b_wo_outlier)
b_sd <- getBatchSd(b_wo_outlier)
b_carbon_balance <- getCarbonBalance(b_wo_outlier, b_cd, cumulate="co2")
saveCarbonBalance(b_carbon_balance, paste(output_dir, "b_carbon_balance.csv", sep = ""))
plot_fermdata(b_wo_outlier, cumulate="co2")
plot_fermdata(b_wo_outlier, cumulate="co2", type = "jpeg",
               filename = paste(output_dir, "b.jpg", sep = ""), width = 1600,
               height = 1000, res = 120)
