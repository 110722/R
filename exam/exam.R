library(BatchFermentationAnalyser)

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
