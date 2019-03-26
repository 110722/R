############################################################################
# ZUSAMMENFASSUNG LETZTE STUNDE:
#
# R nur für Daten Analyse, für alles andere nehmen wir lieber andere Sachen
#
# simple Datentypen
#
# wichtige Folie: in welche Datentypen werden in welche Datentypen umgewandelt!
#
# str() für Structure interaktiv super aber im code net so
# is.logical() oder class() besser
#
# umwandeln mit as.integer() usw.
#
# komplexe Datentypen:
#
# 1 Vektor, linearer Datentyp, immer gleiche Datentypen, im Vektor nicht mischbar
# skalarwert ist in R auch ein Vektor
#
# Index beginnt in R mit 1!!!
# der letzte Index ist immer die Länge
#
# Daten ersetzen: Index ansprechen, neu zuweisen
#
# 2 Faktoren, Kategorien aus Levels und, welcher level auf welchem Index, Levels
# immer Characters, grundsätzlich nicht sortiert
# sortierten Faktor schon bei Erstellung mit order
#
# 3 Matrix, 2 dimensional, Zugriff über [],[] Zeilen, Spalten
#
#################################################################################################


#################################################################################################
#
# heute: alle Infos für Hausübungen
# Start ab Folie 42
#
#################################################################################################
#
# DATAFRAMES:
#
# ähnlich zur Matrix, 2D Struktur, Zeilen und Spalten ABER: Datentypen mischbar
# Spalte muss imemr ein Datentyp sein
# grundsätzlich aus spreadsheets gewohnt
# Spalte für Name, Größe, Eigenschaft und drunter die Werte
# die nächste Spalte kann ein anderer Datentyp sein
# verwend ich wenn ich unterschiedliche Eigenschaften in den Spalten hab (auch wenn alles nur
# Zahlen sind zB Größe, Alter z.B.)
#
# ich erstelle ein dataframe:

df <- data.frame(a = 1:2,
                 b = c(T, F),
                 c = c("a", "b"))
print(df)

# da schreib ich immer = innerhalb

str(df)

# ich hab Spalte a mit integer, b mit logical usw.
# Spalte ansprechen mit

print(df$b)

# das ist jetzt ein Vektor (eine Spalte ist ein Vektor)

df[, 2]
# zweite Spalte, andersrum zweite Zeile
# prinzipiell wie Matrix die einzelnen Werte ansprechbar

# Werte anfügen an Dataframe: wenn ich eine Zeile hinzufüg, dann brauchen die ja unterschiedliche
# Datentypen, es geht aber so:

df2 <- rbind(df, list(5, T, "x"))

# ich erzeuge neues dataframe df2, an das ich eine Liste anhänge mir rbind

print(df2)

# was is da mit dem "x" passiert? in der letzten Spalte waren ja Faktoren (nicht in den Levels drin
# und macht mir deshalb ein NA. weil x net in den Levels drin war)

# neuer df:

df3 <- data.frame(
  a = 1:2,
  b = c(T, F),
  c = c("a", "b"),
  stringsAsFactors = FALSE
)
str(df3)

# stringsAsFactors = FALSE rein, sonst machts mir automatisch Faktoren rein, aber ich kan R sagen, dass es das als Characters
# verarbeiten soll

# oder ich wandle vom ursprünglichen df die Spalte ganz um:
str(df)
df$c <- as.character(df$c)
str(df)

# jetzt funktioniert auch das anhängen mit der list :)

# einzelne Werte ersetzen:
print(df2)
df2$a[2] <- 10
print(df2)

# ganze zweite Spalte ersetzen:
df2[, 2] <- c(F, T, F)
print(df2)

# entfernen von Zeilen und Spalten wie bei Matrix mit dem Minus vor dem Index:
# ich entferne die erste Zeile:
df2[-1, ]
# ich entferne die dritte Spalte:
df2[, -3]

# wenn ich eine Zuweisung mache, überschreib ichs, und wenn nicht, is es nur temporär
# interaktiv is das ein print() aber innerhalb einer Funktion machts natürlich
# keinen Sinn wenn ers berechnet aber dann nix damit macht
#
# "tibble" oder so? machen wir nicht, ist aber auch eine Art Dataframe aus dem tidyverse
# package, das sehr praktisch zu sein scheint fürs tägliche Leben
# ein guter Rat: lerne die basics und setze dic hdann mit dem tidyverse auseinander
#
#################################################################################################
#
# DATENTYP LISTE:
#
# allgemeinster Datentyp, kann alles enthalten: Listen, Vektoren, Faktoren, blah
#
# er glaubt das entspricht dem dictionary in python , aber wir sind uns nicht sicher
#
# ich mache eine Liste (die is auch linear (1,2,3 usw)):
# einzelne Elemente sind durch , getrennt, hier hab ich 3 Listenelemente:

l <- list(1, c(T, F), matrix(1:12, nrow = 2))
print(l)
str(l)

# [[3]] zB sagt mir: das is mein drittes Listenelement

# ich kann meine Listenelemente benennen:

l2 <- list(a = 1,
           b = c(T, F),
           c = matrix(1:12, nrow = 2))
print(l2)

# das zweite Listenelement kann ich auswählen mit dem Namen (b) oder über den Index der Liste
# das sind die [[]]
print(l2$b)
print(l2["b"])
print(l2[[2]])

# einzelne Elemente kann ich auch entweder über Namen und Index oder Index & Index anwählen:
print(l2$b[1])
print(l2[[2]][1])


# Spalteninhalt mit Sonderzeichen und Umlauten kein Ding, nur Spaltenbezeichnungen sollten
# ohne Umlaute sein usw.

# jetzt schauen wir uns an: Liste in einer Liste

l3 <- list(a = list(x = 1:5, y = letters[6:8]),
           b = list(x = LETTERS[10:15], y = 5:8))

# ich benenne hier auch die Listen innerhalb der listen
l3
# ohne print() sieht mans nur so aber im skript macht das nix

# hier seh ich wie ich zugreifen kann:
# $a gibt mir die ersten beiden Listen aus, die unter a sind
# $a$y die eine Liste f, g, h

print(l3$a$y)

# Namen ausgeben lassen:
names(l3)
names(l3$a)

# ich benenne mein Listenelement um (Großbuchstaben sind schöner:)
names(l3)[1] <- "A"
print(l3)

# wieder zurück zur l2 Liste, weil ich möchte Elemente entfernen:
# das zweite Element mag ich weg haben, Vorsicht diesmal nur eine eckige Klammer
l4 <- l2[-2]
print(l4)

# wdh: Liste ist linearer Datentyp (nur eine dimension) - Dataframe und Matrix sind 2D Datentypen
# deshalb hab ich eine eindeutige Positionsangabe mit nur einem Wert in eckiger Klammer


# Element anfügen:

l4$x <- 1:5
l4$b <- 100:102
print(l4)

# das was auf Seite 64 im Skript is, is viel zu kompliziert gedacht
# immer hinten angefügt
# ich kann aber mit den Indizes arbeiten und dazwischen was reinschieben aber das sollte
# meisten net notwendig sein
# wenn ich einen vorhandenen Namen nehm, dann überschreibt ers einfach lalala

# manchmal möchte ich von einer Funktion mehrere Ergebnisse bekommen:
# die pack ich dann in eine Liste
# ich liebe Listen

is.list(l4)

# Konvertierungen mit as.matrix / as.dataframe kommt häufiger vor,
# bei Listen eher vermeiden

################################################################################################
#
# ALLOCATE MEMORY -PERFORMANCE
#
#leere Listen anlegen:

x <- list()

# aber jedesmal wenn ich was anfüg wird gefragt: hab ich den Speicherplatz? check check warten,
# ja hab ich- ok, dann wird was angehängt
# und das dauert offenbar erstaunlich lang oder es läppert sich
# besser vorinitialisieren und dann nicht gebrauchtes wieder weglöschen als jedes mal warten

# leerer Vektor mit lauter Nullen so:

v <- vector(mode = "numeric", length = 10000)
str(v)

# und dann kann ich mit einer Schleife jeden Wert ersetzen

v2 <- vector(mode = "list", length = 5)
str(v2)

m <- matrix(nrow = 10, ncol = 100)
str(m)
# oder
m <- matrix(0, nrow = 10, ncol = 100)
str(m)

# wenn ich in der Schleife hab: abind, abind, abind usw, dann kostet das ur viel Zeit

# hier nochmal mim Dataframe:

df_empty <- data.frame(x = rep(NA, 100), y = NA, Z = NA)
df_empty
# vorinitialisierten dataframe, den ich später befüllen kann


###############################################################################################
#
# aus tidyverse gibts andere Datentypen oder Datumsformat aber für die haben
# wir keine Zeit und man kommt mit denen, die wir haben auch ganz gut aus
#
###############################################################################################
#
#  INPOUT / OUTPUT
#
#

? read.table

# das ist unsere haupteinlesequelle
# Dateiname, Spaltenüberschriften werden automatisch nicht als Überschriften gesehen bei table
# sep = seperator, dec = dezimalpunkt
# default wert in der help funktion drin
# Arguments sind weiter unten
# da muss man ab und zu reinschauen
#
# zerst das working directory mit ... ausssuchen und dann bei more als set working directory
# einstellen
#
# einlesen:

read.table("example.table", header = TRUE)

# aber ich muss es zuweisen
# kommentare werden erkannt aber dafür header net automatisch

dt <- read.table("example.table", header = TRUE)

str(dt)

# ich lese eine csv datei ein (da hab ich beistriche zwischen den Werten)

dt2 <- read.csv("example.csv", comment.char = "#")
str(dt2)

# bei einer csv erkennts mir zwar automatisch den header aer dafür keine kommentare automatisch

# ich mag dass mir Spalte 3 als character (nicht als Faktoren) angezeigt wird, das muss ich extra
# sagen

dt3 <-
  read.csv("example.csv",
           comment.char = "#",
           stringsAsFactors = FALSE)
str(dt3)

# überspringe die ersten 3 Zeilen und dann nimm die nächsten 2 Zeilen und dann aus
# das kann ich auch eine Variable zuweisen

read.table("example.table", skip = 3, nrows = 2)

# Ich definiere beim Einlesen schon im Vorhinein, was ich für Datentypen meine
# Spalten haben:
# ich mach mir meine Column Klassen, wenn ich statt factor, Character schreib, dann nimmt er mir die ersten
# drei Spalten numeric und die letzte zu einem Faktor

classes = c(rep("numeric", 3), "factor")
dt4 <-
  read.csv(
    "example.csv",
    comment.char = "#",
    colClasses = classes,
    header = T
  )
str(dt4)

# das definiert mir natürlich meine Möglichkeiten, die ich nachher hab

# andere Einlesemöglichkeiten gibts auch: .delim, .fwf usw - das steht in dem Skript dann
# aber is jetzt net so wichtig

# Daten einlesen dauert lange, deswegen sollte man alles gleich im R-format abspeichern

# ich lösche alles was im arbeitsspeicher drin is:
rm(list = ls())

# und jetzt lad ich meine R datei:

load("example.rda")
ls()

# ich kann auch skripte einlesen: mein example skript: da wird arbeitsspeicher gelöscht
# dann werden example daten geladen
# dann werden sie gezeigt:
# mit source führe ich R skripte aus

# bei den Dateien die Pfade net vergessen!

source("example_script.R")

# es gibt Beispieldatensätze:

data("iris")
data("cars")

# head() gibt mir die ersten 6 Zeilen:

head(cars)

# SPEICHERN:

# ich mach mir einen Vekotr

x <- 1:10
y <- letters[5:24]

# ich mag nuur x speichern:

save(file = "some.RDATA", list = c("x"))
# VORSICHT= ich brauch die variable in Gänsefüßen!!!!!

ls()
rm(list = ls())
ls()
load("some.RData")
ls()

# das was ich mit save gespeichert hab, kann ich mit load wieder reinladen

# speichert alles was im Workspace is, in eine Datei ab:

save.image(file = "all.RData")
ls()
rm(list = ls())
ls()
load("all.RData")

# mit save speicher ich einzelne Variablen und mit save.image speicher ich den ganzen Workspace


# abspeichern: ich mach amal einen dataframe:

df <- data.frame(a = letters[1:10],
                 b = 1:10)
df
write.csv(df, file = "data.csv")

# Spaltenüberschriften ab und zwilennummerierungen und die Werte

write.table(df,
            table = "data.table",
            quote = FALSE,
            sep = "\t")

# quote False is wenn mich die Gänsefüßchen stören um csv
# und im table gibts auch keine Beistriche
# und als Trennung schreibts mir den Tab

# löschen von Dateien geht mit unlink():

unlink("data.table")

# packages zum Einlesen von Daten im Skript bei I/O auf Seite 26

################################################################################################
#
#  HÜ: Zerst amal Daten einlesen
#  ich will eine Liste aus Dataframes nachm Einlesen
#
################################################################################################
#
# KONTROLLSTRUKTUREN:
#
# if und else wie in python, nur mit {}, Zeilenumbruch nur für bessere Lesbarkeit
#
# if - ich brauch was was logisch ausewrtbar is in der runden Klammer

x <- TRUE
if (x) {
  print("Yes")
}


y <- FALSE
if (!y) {
  print("not")
}


x <- 5
if (x < 10) {
  print("x < 10")
}


if (x > 10) {
  print("x > 10")
} else if (x > 8) {
  print("x > 8")
} else {
  print("x <= 8")
}

# nicht vergessen: code -> reformat code
# immer ein else haben, auch wenns nur ein print("this shouldn't happen") ist

# LOOPS
#
# wie in Python wird jedes Element durchgegangen

for (i in 1:3) {
  print(i)
}

# wenn ich Strg+Enter drück, soll der Cursor entweder in der ersten Zeile oder am Schluss stehen
# sonst nimmt nimmt mir R nur die einzelne Zeile in der der Cursor grad steht
# und wenn i vorher net definiert is, is eer traurig

# wichtig: es muss net numerisch sein!

for (i in c("x", "z", "a", "b")) {
  print(i)
}

# muss kein Vektor sein, kann auch eine Liste sein

# wenns Matrix oder Dataframe is, dann wähl ich die an mit dem Index:
# i fängt bei eins an:
# dann j 1 bis vier
# dann i ist gleich 2
# dann j wieder 1 bis 4

m <- matrix(1:12, nrow = 3)

print(m)

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    print(m[i, j])
  }
}

# andersrum:
for (i in 1:ncol(m)) {
  for (j in 1:nrow(m)) {
    print(m[j, i])
  }
}

# wenn ich Zeile zB 2: nrwo dann lassts mir die erste Zeile aus

# WHILE
#
# solange in der Schleife bis ich falsch werd

i <- 0
while (i < 3) {
  i <- i + 1
  print(i)
}

# ich brauch immer eine Abbruchbedingung
# wenn ich eine Endlosschleife mach, kommt rechts oben ein rotes Stopsymbol damit kaann ichs stoppen

# bei bestimmten Ereignissen möchte ich dass die Schleife übersprungen wird

for (i in 1:4) {
  if (i == 3) {
    next
  }
  print(i)
}

# das gleiche geht bei einer while Schleife auch

i <- 0
while (i < 1000) {
  i <- i + 1
  if (i == 5) {
    break
  }
  print(i)
}

# mit break steigt er aus, also es wird komplett abgebrochen

##############################################################################################
#
#  FUNKTIONEN
#
# entspricht den def in Python
#
# combine is zum Beispiel eine Funktion

c(1, 2, 3, 4)

# oder sum is eine Funktion

sum(1:4)

# alles mit () is eine Funktion

# warum will ich sie ?
# weil ich dadurch den Code immer wieder verwenden kann
# ich schreib das einmal und
# führs dann einfach immer wieder aus
# ich werde konsistent: wenn ich einen Fehler machen, dann mach ich ihn immer
# immer wenn ich etwas öfter mach als einmal, dann sollt ich eine Funktion bauen

# alles was nicht auf eine Seite passt, sollt auch eine eigene Funktion sein

# wie schaut eine Funktion aus? Skript im Kapitel Functions Seite 8/15
# Funktionsname und dem weise ich etwas zu

# functionname <- function(parameter, default = ,  ) { das was passieren soll}

my_sum <- function(x,y){
  sum <- x+ y
  return(sum)
}

# aufrufen:
my_sum(3,4)

###############################################################################################
#
#  HÜ Besprechung
#
# wir schauen uns an was im exam.R drinsteht
# exam.R muss dort ausgeführt werden wo input und output liegen
# input dir und output dir steht drin
# a sind die Dateien die eingelesen werden
# a ist Vektor mit 8 Dateinamen
# a1.txt bis A8.txt
# Zeitpunkt und 4 Messwerte

# Funktion: read batchdataset
# x iste ien vector von filenamen und ich muss mit einer schleife drrübergehen
# soll alle Dateien in ein Dataframe und alle Dataframes in eine Liste packen
# zum schluss eine Liste mit return statement zurückgeben

# read.cpumdound data funktion erstellen
# x is ein Dateiname
#
# die beiden Funktionen schreiben
#
# Abgabe per Mail vor der nächsten Vorlesung 11.3.
# Zeilen 3-8 und Zeilen 19 - 21 sollten laufen, den rest auskommentieren
#
# schicken: eine R datei oder 2 R dateien oder reinschreiben in das file exam.R unter 
# die Zeile mit library

