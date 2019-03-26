# WIEDERHOLUNG

# save.image speichert ganzen workspace ab

# if else & loops
# for schleife iterierts über elemente des vektors



#############################################################
#
#
# Funktionen - Wdh.
#
#
#############################################################

my_sum <- function(x, y) {
  s <- x + y
  return(s)
}


# man soll lokale Variablen verwenden in Funktionen, das is besser
my_sum(4, 5)

# schlechte Praxis:
my_sum2 <- function(x, y) {
  s <- x + y
  s
}

# warum is das schlecht: deshalb:
get_larger_w <- function(x, y) {
  if (x > y) {
    return(x)
  }
  return(y)
}

get_larger_w(3, 2)

# ohne return wird immer das letzte ausgegeben ohne Rücksicht auf verluste
get_larger_w2 <- function(x, y) {
  if (x > y) {
    x
  }
  y
}

get_larger_w2(3, 2)

##########################################################
#
#
# default parameter
#
#
###########################################################

# default wert für y,
# wenn kein y wert extra eingesetzt wird oder angegeben,
# wird automatisch 10 genommen

is_larger <- function(x, y = 10) {
  if (x > y) {
    return (TRUE)
  }
  return(FALSE)
}
is_larger(11)

# x bekommt den Wert 11, default y = 10

is_larger(5)

is_larger(5, 4)

is_larger(y = 4, x = 5)

############################################################
#
#
#  AUsreisser entfernen
#
#
#############################################################

boxplot(rnorm(100, 10, 1))

# wir definieren: alles außerhalb der IQR des Boxplots is ein Ausreisser
# ich definiere in Zeile 98 na.rm als default True und in der nächsten Zeile
# ist der erste na.rm der, der dem quantile() übergeben wird und der zweite 
# ist der aus meiner Funktions-definition
# ich mach das damit ich konsistent bin mit den vorgegegebne Funktionen
# q[1] ist mein 0.25 quantil -- ich setzte die ausreisser NA

remove_outliers <- function(x, na.rm = TRUE) {
  q <- quantile(x, probs = c(0.25, 0.75), na.rm = na.rm)
  d <- 1.5 * IQR(x, na.rm = na.rm)
  x[x < (q[1] - d)] <- NA
  x[x > (q[2] + d)] <- NA
  return(x)
}

# ich mach ausreisser vektor

v <- c(1, rnorm(10, mean = 10, sd = 1), 15)
remove_outliers(v)

# in unserem hü-satz haben wir liste darin dataframes und darin spalten
# ich muss in die spalten
# wir haben 4 messwerte und da kann ein ausreisser drin sein

###############################################################################
#
#
#   Operations
#
#
###############################################################################

x <- 1:5
x + 1

x <- 1:6
x + 1:2

# R recycelt: r macht plus 1 dann plus 2 dann plus 1 dann plus 2 bis 
# die länge des vektors erreicht ist

x <- 1:5
x + 1:2

# recycling geht sich net aus :(

x * 2
x / 2

# potenz
x ^ 2
x ** 2

# wurzel
sqrt(x)
#dritte wurzel
x ^ (1 / 3)

# modulo %% gibt rest einer division aus

# rundungsfunktionen

floor(1.99)
# rundet immer ab
ceiling(1.01)
# rundet immer auf
round(c(1.49, 1.5, 1.51))
round(c(1.5, 2.5))
# 1.5 wird aufgerundet und 2.5 wird abgerundet !!


round(1.456, digits = 2)

x <- 1:5
sum(x)
cumsum(x)
# kummulierte Summe: Werte werden aufsummiert
# zB Co2 im batch das verpufft, das muss zB aufsummiert werden

# wenn ich setseed mach hab ich jedesmal das gleiche wenn ich random mach
set.seed(1)
x <- runif(100, 0, 10)
x
# letzter wert bei allen gleich, die seed 1 haben (aber trotzdem zufällig verteilt)
# jedesmal bevor man die x aufruft, muss man set seed aufrufen wenn man das gleiche haben will

min(x)
max(x)

summary(x)
class(x)
str(x)


mean(x)

sd(x)
#standardabweichung

var(x)
# varianz

median(x)
quantile(x)
mad(x)
# median absolute deviation

IQR(x)
# wert zwischen 25-75% qantil
quantile(x)[4] - quantile(x)[2]


# nachkommastellen formatieren
v <- 0.1234567
print(v)
sprintf("%.3f", v)
# aber keine zahl mehr
options(digits = 3)
print(v)
# digits setzten bis zur 16 Nachkommastelle, das bleibt dann - insgesamt hab ich nur 16 stellen


# Matrixoperationen

m <- matrix(1:6, nrow = 2)
m
summary(m)
# für jede Spalte!!!!

t(m)
# transponiert Matrix
summary(t(m))

sum(m)
colSums(m)
rowSums(m)

mean(m)
colMeans(m)
rowMeans(m)

# mittelwerte aus 4 Messerwerten bei unserem Beispiel muss man berechnen

m <- matrix(1:12, nrow = 3)
s <- subset(m, rowSums(m) > 25)

#############################################################
# 
# which is cool
#
#############################################################

s
# index ändert sich auch: subset s von matrix, wo reihensumme über 25 ist
# oder
s2 <- m[which(rowSums(m) > 25),]
s2
# mit which kann man das auch aussuchen, which rowsums von m und dann , und dann spalten (ich nehm alle deshalb frei)

rowSums(m) > 25
# false true true
# which gibt mir index zurück, wo ich den wert true habe
which(rowSums(m) > 25)



m
colnames(m) <- c("x", "y", "z", "a")

m <- matrix(1:6, nrow = 2)
m * m
# elementweise

m * 1:2
# macht elementweise zerst mal 1 dann mal 2 dann mal 1 dann mal 2

# kreuzprodukt
m <- matrix(1:6, ncol = 2)
v <- 2:3
m %*% v


f <- factor(c("a", "b", "b", "a", "c"))
summary(f)  # wieviele und welche werte
levels(f)  # nur die levels selbst die vorkommen dürfen, aber net alle müssen auch werte haben
length(levels(f))
# das gleiche wie
nlevels(f)

f[1] < f[2]
# wenn ichs reihen will:
f <- factor(c("a", "b", "b", "a", "c"),
            levels = c("a", "b", "c"),
            ordered = TRUE)
f[1] < f[2]
order(f)

f[order(f)]  # das gleiche wie
sort(f)


# dimensionen von matrizen
m <- matrix(1:6, ncol = 2)
dim(m)
# erste zeilen dann spalten
dim(m)[1] # zeile
dim(m)[2] # spalten
# das gleiche wie
nrow(m)
ncol(m)


#########################
#
# logicals
#
#########################

T & F   # und
T | F   # oder - mindestens eins True

# elementweise- alle indizes miteinander elementweise verglichen
c(T, F, F) & c(T, T, F)

# umkehren eines logischen wertes!TRUE
! (TRUE | FALSE)

xor(T, T)
# ausschließliches oder: nur eines darf

all(c(T, F, T))
all(c(3, 4, 5) > 2) # sind alle elemente in meinem vektor >2, dann bekomm ich true

# 1 true element reicht aus:
any(c(T, F, F))


x <- letters[1:3]
all.equal(x, c("a", "b", "c"))   # positionsabhängig"!
all.equal(x, letters)
all.equal(x, 1:3)
# tückisch in funktionen - bessser interaktiv
# in funktion verwend ich identical

identical (x, c("a", "b", "c"))

# wahrheitstabelleseite 45/51!!!
# wichtig

####################################################################
#
#
# NA operations
#
#
####################################################################


df <- data.frame(a = 1:3, b = c(2, NA, 7))
df
# zweite zeile, zweite spalte steht NA
rowSums(df)
# das gibt mir NA aus

na.omit(df)
# entfernt alle ZEILEN wo NA steht
na.exclude(df)

rowSums(df)

# ich wil NA ignorieren
rowSums(df, na.rm = TRUE)

m <- matrix(rnorm(12, 10, 1), nrow = 3)
m[2, 2] <- NA
rowSums(m, na.rm = T)
colSums(m, na.rm = T)


###############################################################################
#
#
# APPLY
#
#
###############################################################################

# apply als Ersatz für eine schleife wenn ich schon datensatz da hab

m <- matrix(1:12, nrow = 3, byrow = T)
m

# apply(was ich übergeb, Zeilenweise/spaltenweise, Funktion)
# 1 zeilenweise, 2 ist spaltenweise
apply (X = m, MARGIN = 1, FUN = sum) # so kamm ich rowSums zB schreiben
apply(m, 1, sum) # parameter wie in doku schreiben oder die richtige Position machen

apply(m, 2, sum)
colSums(m)

m[2, 2] <- NA
apply(m, 1, sum) # NA wieder net dabei
apply(m, 1, sum, na.rm = T) 

# alles was nach den funktionen kommt, sind parameter für diese funktion!!

m <- matrix(1:12, nrow = 3, byrow = T)
apply(m, 1, function(x) {
  a <- median(x)
  b <- -1 * a
  return(b)
})
# anonyme funktion - ich übergebe der funktion die zeile. 
# (von apply) x ist die zeile. anonyme funktion
# ok für kleine und einfache
# ich wende die selbstgeschriebene Funktion auf alle 1(Zeilen) von m an

negativeMedian <- function(x, na.rm = T) {
  a <- median(x, na.rm = na.rm)
  b <- -1 * a
  return(b)
}
m[2, 2] <- NA
apply(m, 1, negativeMedian)
apply(m, 1, negativeMedian, na.rm = F)

# normalerweise bekomm ich immer vektor zurück weil ich ja entweder spaltenweise oder zeilenweise drüber geh

# geht auch mit vektoren und listen:

# LAPPLY für Listen:

v <- 1:3
lapply(v, function(x) {
  return(2 * x)
})
# da brauch ich kein margin
# obwohl ich vekotr übergebe bekomme ich eine liste zurück
# alles ein eigener listeneintrag

# SAPPLY für Vektoren

sapply(v, function(x) {
  return(2 * x)
})
# da bekomm ich einen Vektor zurück

#
#
##########################################################
#
# Hausübung: es geht schon weiter juhu!
# ausreisser- vierfachmessungen
# mit IQR*1,5 raushauen - man muss in list, in dataframe in spalte
# get batch means & sd - für jeden dataframe einen wert für gluc, co2 usw
# da sollt dataframe zurückkommen
# co2 bilanz
# list of batch data.frames
# in cd is kohlenstoffzusammensetzung drin
# cumulate co2 mit cumsum aufsummieren
# sowas wie die tabelle kommt raus
# gemessene werte & molekulargewicht und wieviele kohlenstoffe pro
# spalten sind nicht gleich sortiert VORSICHT


##################
#
#  plots
#
####################

? plot
? plot.default

x <- seq(-20, 20, by = 4)
plot(x)
plot(x, type = 'b')
#   p points, l line, o beides, b punkte mit abstandlinien, etc

plot(runif(30), type = 'h')

# leerer plot:
plot(x, type = 'n')
# zum vordefinieren der achsen und dann kann ich den rest reinplotten

par()
# alle parameter, die für unsere plots gültig sind

op <- par() 
# orignalparameter in variable speichern daweil damit ich wieder
# zurücksetzen kann nachher
par(op)  #errors egal hier

#nebeneinander sind die plots
par(mfrow = c(1, 2))
plot(1:10)
plot(1:10, type = 'l')

par(mfrow = c(1, 1))
# oder mfrow=2,2 dann hab ich 4 Grafiken nebeneinander

par(mfrow = c(2, 2))
# mir sind die ränder zu viel
par(mfrow = c(1, 1))

# ich setze ränder unten, links oben rechts
par(mai = c(0, 0, 0, 5))
plot(1:10)

par(mar = c(1, 2, 2, 1))

par(oma = c(1, 2, 2, 1) + 0.1)
plot(1:10)

# par resetten:
par(op)

# jedesmal plotten wird das neu gezeichnet, wenn ich will dass es reingezeichnet wird:
par(new = T)
plot((1:10) ^ 10)


par(op)


# install.packages("roxygen2")
# install.packages("devtools")
