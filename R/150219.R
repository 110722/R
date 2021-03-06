#############################################################################
#####      
#####       CHAPTER 1 - simple datatypes
#####
#############################################################################

# get working directory
getwd()

# Zuweisung Variable
a <- 5L
#Zuweisung Parameter (wenn ichs einer Funktion übergeb)
b = 6


# mit L hinten is es ein Integer, sonst is es automatisch numerisch
class(a)
class(b)

# ich erstelle Vektor mit :
1:5
# eins bis fünf in Einser-Schritten
class(1:5)
# einziger Fall wos automatisch Integer erzeugt und net numerisch

# unendlich ist numerisch - großes I bei Inf
class(Inf)

# kommt selten vor: not a number (nicht not available!!!)
class(NaN)

# strings heißen characters
class("abc")
class('abs')

# print printet wie in Python
print("das is lustig")

# TRUE kann man abkürzen mit T, FALSE mit F
# in Funktionen aber meisten ausgeschrieben
class(T)
class(F)

# NULL is nichts
class(NULL)


# REQUEST DATATYPE

# str zeigt mir an, was es is und eine Vorschau (von den ersten tausend zB.)
# nur so verwenden.
str(1:1000)

# in echt:
is.integer(5)
# false
is.integer(5L)
# true

# ich sollt vorher abfragen ob meine daten überhaupt für meine Operation passsen: ein
# Character kann ich mit mit numeric multiplizieren zB

# ich übergebe Variable die not available is?
is.na(NA)

# ich frage ab: ist eine NA in einem  Vektor? Ich mach Vektor mit c()
# ich weiß gleich: an der vierten Stellen fehlen Daten
# es ist nicht nichts- es ist ein NA- Wert -> ich kann keine Summe bilden (NA kann alles sein)
# ich müsst vorher NA entfernen
# fehlerhafte Dateneinlese zB.: 1,1,1,2,,2,1,2  <- dort is NA Wert, wenn ichs einles in R
# später deklarier ich meine Ausreißer mit NA-Wert
is.na(c(1,2,3,NA,4,5))

# NULL zeigt im Speicher auf eine nPlatz, die das Nichts kennzeichnen - irgendwie blöd
n <- NULL
is.null(n)
# hier nicht weiterrechnen das bringt nur Scherereien


# ist mein Wert endlich?
is.finite(1000)



# MIX DATATYPES

# logical -> integer -> numeric -> character 

# in einem Vektor dürfen nur gleiche Daten vorhanden sein
str(c(T,1))
# ich bekomm 1 und 1 zurück

str(c(T, "abc"))
# wieder umgewandelt in das rechteste, damit nix an Info verloren geht

str(c(F, 3L, -5, "name"))
# alles wird in Character umgewandelt

# CONVERT DATATYPES


# ich kann das aber auch erzwingen, als was es gesehen wird
str(as.integer(TRUE))
# machts mir zu einer Integer

# "TRUE" wird obwohls ein Character is umgewandet in die boolean, weil ers erkennt
str(as.logical("TRUE"))

str(as.logical("name"))
# Name kann nicht in einen boolschen Operator umgewandelt werden, deshalb NA


##########################################################################################
#####
#####         CHAPTER 2: COMPLEX DATATYPES
#####
##########################################################################################

# VECTOR
# entspricht Array, Abfolge von Daten des gleichen Datantyps

# create mit c() (steht für combine)
x<- c(1,2,3)
print(x)

# auch aus Characters anlegbar
c("a", "b", "c")

# auch unterschiedliche Datentypen verwendbar, aber die werden nach oben genannter Reihenfolge
# konvertiert
c(T, 1, "hello")

# geht auch zum kombinieren
a <- c(1,3,4)
v <- c(-4,-9)
c(a, b)

# geht auch mit :
5:10
3:-8
# braucht man oft in for Schleifen'
# geht auch mit seq()
# is das gleiche wie mit :- Operator
seq(1,5)
# aber auch mit anderen Einstellungen möglich
seq(1,10, by = 2)
seq(1,10, length = 3)


# alles markieren und auf code -> reformat code: macht die schicken Abstände rein

# wenn man in der Console ein > hat, startets, wen ndas ein + wird, dann is das Command
# noch nicht beendet: Klammer zumachen oder so

# eckige Klammer weils ein Vektor is
v <- letters[1:3]

seq(1,10, along.with = v)
# machts genauso lang wie meinen v- Vektor

seq_along(v)
# beginnt bei eins und geht über Länge des Vektors - gut für For Schleifen

seq_len(9)
# entspricht 1:9, weil das beginnt auch bei eins

# repeat
rep(5, 10)
rep(TRUE, 5)
# wiederholt das erste Element so oft wie das zweite da steht
# geht nicht:
# "abc" * 5
# skript stoppt an stelle wenns net gehen würd

# ich bau mir einen lustigen Vektor:
x <- c(seq(1,5), rep(9,4), -42, 5:8)

is.vector(x)

# die Länge
length(c("a", "x"))

# in R gibts keine Skalarwerte: keine Einzelwerte. Intern sind alle Sachen  Vektoren
is.vector(5)

# VORSICHT: R beginnt seinen Index mit 1
v <- 1:100
v[5]

# Index in der eckigen Klammer (auch ein Vektor)
# das kann auch ein langer Vektor sein
v2 <- c(5,9,13)
v[v2]
v2[2]

# logischer Vektor wird ausgegegeben
# welche Werte sind kleiner 10??
index2 <- v < 10
print(index2)

v[index2]
# oder
v[v<10]
# gibt mir die Werte wo index2 TRUE is, als 1-9

# ich möchte an einer Stelle einen Werte ersetzen
v[5] <- NA
# an 5. Stelle möcht ich ein NA stehen haben
v[c(8,10)] <- NA
# an 8. und 10. Stelle möcht ich auch ein NA stehen haben

print(v)
# wo hab ich ein NA
is.na(v)

# Index von den NA werten
which(is.na(v))

# ich möcht diese NA-werte gleich null setzen, der erste Teil is Werte von Positionen 5,8,10
# und setz diese auf null
v[is.na(v)] <- 0 
# in eckiger Klammer hab ich einen logischen Wert drin
print(v)


# Werte einfügen in Vektor geht grundsätzlich amal nicht so leicht
# neuer Vektor v2

v2 <- 1:10
print(v2)

# ich verändere v2 hier nicht und füge zwischen 5 und 6 einen 1000er ein
c(v2[1:5], 1000, v2[6:10])
# wenn ich ihne verändern mag, einfach neu zuweisen mit v2 <- usw.

# Pltze löschen geht leichter
v2[-2]
# zweite Position ist gelöscht mit minus
v2[-c(3,5)]


# FACTOREN 
# wenn ich wenn ich was einteilen kann in Kategorien
# kategorische Werte

str(factor(c("a", "b", "c", "a", "b", "b")))
# Factor besteht aus drei Levels (a b und c)
# zuerst Levels a b c, dann die Indizes davon
# Levels-Vektor is ein CHaracter
# Kategorien sind immer Characters - Levels = Kategorie

# so is es schön:
f <- factor(c("a", "b", "c", "a", "b", "b"))
summary(f)

table(f)
# gibt zusätzlich variablennamen an

# super einfach plotbar
plot(f)

# kann ich das vergleichen? nur wenn ich dem R sag, wie sie zu sortieren sind:

# welche Werte kommen vor,
# welche Levels gibt es, wenns ein anderer ist, dann is es NA und die Reihenfolge in der sie zu sortieren sind
# sie sind sortiert, aufsteigend nach der Reihenfolge der Angabe in den levels!!!
f3 <- factor(c("s", "m", "s", "l", "m", "s"),
             levels = c("s", "m", "l"),
             ordered = TRUE)
str(f3)
f3[1] < f3[2]   # TRUE 


# MATRIZEN

# 2-D Vektoren
# R macht wieder einen Datentype drauf nach der Reihenfolge, wie oben bei den Vektoren

# ich mach eine Matrix:
# Werte, dann Zeilen und Spalte
m <- matrix(1:12,nrow = 3, ncol = 4)

# manchmal mag ichs anders befüllt haben
matrix(1:12, nrow=3, ncol=4, byrow = TRUE)

class(m)
is.matrix(m)

# Matrix mit leeren Werten als Platzhalter erstellen
matrix(nrow=2, ncol=2)
# da is alles NA

# will ich null dann so:
d<-matrix(0, nrow=2, ncol=2)
# da gehen auch characters und TRUE oder was weiß ich
# Null wird recycelt, bis alles voll is

matrix(c(0,1), nrow=2, ncol=3)
# 0 1 wird solang verwendet bis alles voll, wenn sichs net ausgeht, dann krieg ich eine Warnung

# sagt mir die Einträge
length(d)
# Dimension: Zeilen und dann Spalten
dim(m)
zeilen <- dim(m)[1]
print(zeilen)

nrow(m)
ncol(m)

# Zugriff auch mit eckiger Klammer, aber m[Zeile, Spalte]
m[2,2]
m[1:2,2]

m[-1,]
#zeigt Spalte ohne erste Zeile an
m[,-2]
# zeigt Matrix ohne zweite Spalte an

m[-1, -c(2,3)]

# wenn ein Wert weggelassen wird, nimmt R gleich alle Werte dort


# Werte hinzufügen? Spalte oder Zeile
cbind(m, rep(1,3))
# ich bekomm 5. Spalte mit dreimal dem Wert eins. das würd auch so funktionieren, weil der Wert recycelt wird

rbind(m, 1000:1003)
# ich bekomm noch eine Spalte

# soland ichs nicht zuweise, bleibt m original!!
# im normalfall dann wieder zuweisen
m <- rbind(m, 1000:1003)
print(m)

# Werte ersetzen:
#ich such ausm Index meine Werte und ersetz sie
m[1,2] <- NA
# erste Zeile, zweite Spalte wird zu einem NA
print(m)

# Zeilen und Spalten beschriftbar

n <- matrix(1:12, nrow= 3)
rownames(n) <- LETTERS[1:3]
colnames(n) <- letters[1:4]
print(n)
# ich kann jetzt mit den Buchstaben drauf zugreifen
n["B", "c"]

colnames(n)
which(colnames(n) == "b")
# welche Spaltennamen sind b? Spalte nummer 2

#############################################################################################