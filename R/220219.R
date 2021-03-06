############################################################################
# ZUSAMMENFASSUNG LETZTE STUNDE:
#
# R nur f�r Daten Analyse, f�r alles andere nehmen wir lieber andere Sachen
#
# simple Datentypen
#
# wichtige Folie: in welche Datentypen werden in welche Datentypen umgewandelt!
#
# str() f�r Structure interaktiv super aber im code net so
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
# der letzte Index ist immer die L�nge
#
# Daten ersetzen: Index ansprechen, neu zuweisen
#
# 2 Faktoren, Kategorien aus Levels und, welcher level auf welchem Index, Levels
# immer Characters, grunds�tzlich nicht sortiert
# sortierten Faktor schon bei Erstellung mit order
#
# 3 Matrix, 2 dimensional, Zugriff �ber [],[] Zeilen, Spalten
#
#################################################################################################


#################################################################################################
#
# heute: alle Infos f�r Haus�bungen
# Start ab Folie 42
#
#################################################################################################
#
# DATAFRAMES:
#
# �hnlich zur Matrix, 2D Struktur, Zeilen und Spalten ABER: Datentypen mischbar
# Spalte muss imemr ein Datentyp sein
# grunds�tzlich aus spreadsheets gewohnt
# Spalte f�r Name, Gr��e, Eigenschaft und drunter die Werte
# die n�chste Spalte kann ein anderer Datentyp sein
# verwend ich wenn ich unterschiedliche Eigenschaften in den Spalten hab (auch wenn alles nur
# Zahlen sind zB Gr��e, Alter z.B.)
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

# Werte anf�gen an Dataframe: wenn ich eine Zeile hinzuf�g, dann brauchen die ja unterschiedliche
# Datentypen, es geht aber so:

df2 <- rbind(df, list(5, T, "x"))

# ich erzeuge neues dataframe df2, an das ich eine Liste anh�nge mir rbind

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

# oder ich wandle vom urspr�nglichen df die Spalte ganz um:
str(df)
df$c <- as.character(df$c)
str(df)

# jetzt funktioniert auch das anh�ngen mit der list :)

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

# wenn ich eine Zuweisung mache, �berschreib ichs, und wenn nicht, is es nur tempor�r
# interaktiv is das ein print() aber innerhalb einer Funktion machts nat�rlich
# keinen Sinn wenn ers berechnet aber dann nix damit macht
#
# "tibble" oder so? machen wir nicht, ist aber auch eine Art Dataframe aus dem tidyverse
# package, das sehr praktisch zu sein scheint f�rs t�gliche Leben
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

# das zweite Listenelement kann ich ausw�hlen mit dem Namen (b) oder �ber den Index der Liste
# das sind die [[]]
print(l2$b)
print(l2["b"])
print(l2[[2]])

# einzelne Elemente kann ich auch entweder �ber Namen und Index oder Index & Index anw�hlen:
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

# ich benenne mein Listenelement um (Gro�buchstaben sind sch�ner:)
names(l3)[1] <- "A"
print(l3)

# wieder zur�ck zur l2 Liste, weil ich m�chte Elemente entfernen:
# das zweite Element mag ich weg haben, Vorsicht diesmal nur eine eckige Klammer
l4 <- l2[-2]
print(l4)

# wdh: Liste ist linearer Datentyp (nur eine dimension) - Dataframe und Matrix sind 2D Datentypen
# deshalb hab ich eine eindeutige Positionsangabe mit nur einem Wert in eckiger Klammer


# Element anf�gen:

l4$x <- 1:5
l4$b <- 100:102
print(l4)

# das was auf Seite 64 im Skript is, is viel zu kompliziert gedacht
# immer hinten angef�gt
# ich kann aber mit den Indizes arbeiten und dazwischen was reinschieben aber das sollte
# meisten net notwendig sein
# wenn ich einen vorhandenen Namen nehm, dann �berschreibt ers einfach lalala

# manchmal m�chte ich von einer Funktion mehrere Ergebnisse bekommen:
# die pack ich dann in eine Liste
# ich liebe Listen

is.list(l4)

# Konvertierungen mit as.matrix / as.dataframe kommt h�ufiger vor,
# bei Listen eher vermeiden

################################################################################################
#
# ALLOCATE MEMORY -PERFORMANCE
#
#leere Listen anlegen:

x <- list()

# aber jedesmal wenn ich was anf�g wird gefragt: hab ich den Speicherplatz? check check warten,
# ja hab ich- ok, dann wird was angeh�ngt
# und das dauert offenbar erstaunlich lang oder es l�ppert sich
# besser vorinitialisieren und dann nicht gebrauchtes wieder wegl�schen als jedes mal warten

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
# vorinitialisierten dataframe, den ich sp�ter bef�llen kann


###############################################################################################
#
# aus tidyverse gibts andere Datentypen oder Datumsformat aber f�r die haben
# wir keine Zeit und man kommt mit denen, die wir haben auch ganz gut aus
#
###############################################################################################
#
#  INPOUT / OUTPUT
#
#

? read.table

# das ist unsere haupteinlesequelle
# Dateiname, Spalten�berschriften werden automatisch nicht als �berschriften gesehen bei table
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
# kommentare werden erkannt aber daf�r header net automatisch

dt <- read.table("example.table", header = TRUE)

str(dt)

# ich lese eine csv datei ein (da hab ich beistriche zwischen den Werten)

dt2 <- read.csv("example.csv", comment.char = "#")
str(dt2)

# bei einer csv erkennts mir zwar automatisch den header aer daf�r keine kommentare automatisch

# ich mag dass mir Spalte 3 als character (nicht als Faktoren) angezeigt wird, das muss ich extra
# sagen

dt3 <-
  read.csv("example.csv",
           comment.char = "#",
           stringsAsFactors = FALSE)
str(dt3)

# �berspringe die ersten 3 Zeilen und dann nimm die n�chsten 2 Zeilen und dann aus
# das kann ich auch eine Variable zuweisen

read.table("example.table", skip = 3, nrows = 2)

# Ich definiere beim Einlesen schon im Vorhinein, was ich f�r Datentypen meine
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

# das definiert mir nat�rlich meine M�glichkeiten, die ich nachher hab

# andere Einlesem�glichkeiten gibts auch: .delim, .fwf usw - das steht in dem Skript dann
# aber is jetzt net so wichtig

# Daten einlesen dauert lange, deswegen sollte man alles gleich im R-format abspeichern

# ich l�sche alles was im arbeitsspeicher drin is:
rm(list = ls())

# und jetzt lad ich meine R datei:

load("example.rda")
ls()

# ich kann auch skripte einlesen: mein example skript: da wird arbeitsspeicher gel�scht
# dann werden example daten geladen
# dann werden sie gezeigt:
# mit source f�hre ich R skripte aus

# bei den Dateien die Pfade net vergessen!

source("example_script.R")

# es gibt Beispieldatens�tze:

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
# VORSICHT= ich brauch die variable in G�nsef��en!!!!!

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

# Spalten�berschriften ab und zwilennummerierungen und die Werte

write.table(df,
            table = "data.table",
            quote = FALSE,
            sep = "\t")

# quote False is wenn mich die G�nsef��chen st�ren um csv
# und im table gibts auch keine Beistriche
# und als Trennung schreibts mir den Tab

# l�schen von Dateien geht mit unlink():

unlink("data.table")

# packages zum Einlesen von Daten im Skript bei I/O auf Seite 26

################################################################################################
#
#  H�: Zerst amal Daten einlesen
#  ich will eine Liste aus Dataframes nachm Einlesen
#
################################################################################################
#
# KONTROLLSTRUKTUREN:
#
# if und else wie in python, nur mit {}, Zeilenumbruch nur f�r bessere Lesbarkeit
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

# wenn ich Strg+Enter dr�ck, soll der Cursor entweder in der ersten Zeile oder am Schluss stehen
# sonst nimmt nimmt mir R nur die einzelne Zeile in der der Cursor grad steht
# und wenn i vorher net definiert is, is eer traurig

# wichtig: es muss net numerisch sein!

for (i in c("x", "z", "a", "b")) {
  print(i)
}

# muss kein Vektor sein, kann auch eine Liste sein

# wenns Matrix oder Dataframe is, dann w�hl ich die an mit dem Index:
# i f�ngt bei eins an:
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

# bei bestimmten Ereignissen m�chte ich dass die Schleife �bersprungen wird

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
# f�hrs dann einfach immer wieder aus
# ich werde konsistent: wenn ich einen Fehler machen, dann mach ich ihn immer
# immer wenn ich etwas �fter mach als einmal, dann sollt ich eine Funktion bauen

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
#  H� Besprechung
#
# wir schauen uns an was im exam.R drinsteht
# exam.R muss dort ausgef�hrt werden wo input und output liegen
# input dir und output dir steht drin
# a sind die Dateien die eingelesen werden
# a ist Vektor mit 8 Dateinamen
# a1.txt bis A8.txt
# Zeitpunkt und 4 Messwerte

# Funktion: read batchdataset
# x iste ien vector von filenamen und ich muss mit einer schleife drr�bergehen
# soll alle Dateien in ein Dataframe und alle Dataframes in eine Liste packen
# zum schluss eine Liste mit return statement zur�ckgeben

# read.cpumdound data funktion erstellen
# x is ein Dateiname
#
# die beiden Funktionen schreiben
#
# Abgabe per Mail vor der n�chsten Vorlesung 11.3.
# Zeilen 3-8 und Zeilen 19 - 21 sollten laufen, den rest auskommentieren
#
# schicken: eine R datei oder 2 R dateien oder reinschreiben in das file exam.R unter 
# die Zeile mit library

