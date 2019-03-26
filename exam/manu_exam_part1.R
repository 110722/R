# Funktionen readBatchDatasets und readCompoundData nach den Kommentaren schreiben
#
# Abgabe bis spÃ¤testens 11.03.2019 15:00 Uhr per mail an
# matthias.gerstl@boku.ac.at
#
# Zum Testen muss das Skript und die Ordner input und output im Working directory liegen
# Funktioniert das nicht probiere folgende Schritte:
#   1. Erstelle im rstudio ein neues Projekt
#   2. Kopiere die Ordner input und output in den neuen Projektordner
#   3. Kopiere diese Datei in den neuen Projektordner und Ã¶ffne dann die Datei im rstudio


# Du hst a und a_d usw weiter unten dann anders definiert, ich bin mir net sicher, wie sehr sich die 
# gegenseitig überschreiben, schrib lieber function (x)

# du willst rauskriegen bei readbatchdatasets: eine liste aus dataframes
# hier mein Code, bitte fest abändern :p

# mit einem while loop gehst du eher "numerisch" durch. mit einem for-loop
# bist auf der sichereren seite wenn du über alle elemente einzeln iterieren willst. 


# readBatchDatasets <- function(x) {
#   mylist <- vector(mode = "list", length = length(x))  # leere Liste zum memory allokieren
#   e = 1                                               # Zähler auf eins setzen
#   for (i in x) {                                      # für jedes element in x (liste der filenamen, schon vordefiniert)
#     mylist[[e]] <- read.table(i,                      # liest du dieses file ein
#                               header = TRUE,
#                               colClasses = "numeric")
#     e = e + 1                                         # und erhöst den zähler um 1
#   } 
#   return(mylist)
# }
# 
# 
# readCompoundData <- function(x) {                   # da liest du nur die andere tabelle ein
#   mycompounds <- read.table(x)
#   return(mycompounds)
# }




ReadBatchDatasets <- function (x){                  # mach x, sonst liest du immer nur a ein und b nicht
#########################################################
  #Takes the vector (a) (containig all file names), reads in files as data frames and merges
  #to one data frame
  #Return list of complete data frame

  #Generate first data frame with first file from vector (a)
  path1 <- x[1]                                   
  a_d1 <- read.table(path1, header = TRUE, sep = "\t")  
  
  #Read in remaining data frames with loop function
  i <- 2
  while (i < length(a)){
      i <- i+1
     #print (i)
     path <- x[i]
     a_dtemp <- read.table(path, header = TRUE, sep = "\t")
     a_d <- rbind.data.frame(a_d1, a_dtemp)
     rm(a_dtemp)
     }
  }
  print(a_d)

    
# #Starting from vector (a)
#   path1 <- a[1]
#   a_d1 <- read.table(path1, header = TRUE, sep = "\t")
# 
# #manually without looping it would work like this:
#    path2 <- a[2]
#    a_d2 <- read.table(path2, header = TRUE, sep = "\t")
#    #...
#    #pathn <- a[n]
#    #a_dn <- read.table(pathn, header = TRUE, sep = "\t")
#    a_d <-  rbind(a_d1, a_d2)#, ... a_dn)
# 
#  print(a_d)
#  }
#  
 

readCompoundData <- function()










# Die folgenden Zeilen nicht Ã¤ndern

basis_dir <- getwd()
input_dir <- paste(basis_dir, "/input/", sep = "")
output_dir <- paste(basis_dir, "/output/", sep = "")
a <- paste(input_dir, "A/A", 1:8, ".txt", sep="")
a_d <- readBatchDatasets(a)
a_cd <- readCompoundData(paste(input_dir, "A/Compounds.txt", sep = ""))

b <- paste(input_dir, "B/B", 1:8, ".txt", sep="")
b_d <- readBatchDatasets(b)
b_cd <- readCompoundData(paste(input_dir, "B/Compounds.txt", sep = ""))

str(a_d)
str(a_cd)
str(b_d)
str(b_cd)
