#########################
#
#
#    Plot weiter (Vektorplot)
#
#
#########################

install.packages("ggplot2")

x <- 1:100
plot(x)
plot(x, xlim= c(20,80), ylim=c(50,100))

originalpar <- par()

par(mfrow=c(2,2), mar=c(2,2,1,1))
# unten links oben rechts
plot(x)

# logarithmieren:
plot(x, log="x")
plot(x, log="y")
plot(x, log="xy")


par(mfrow=c(1,1), mar=c(5,4,4,2)+.1)

# titel setzen:
# Untertitel is unter der x-Achsen-Beschriftung
plot(x, main="Mein Titel", sub= "Untertitel")

par(originalpar)

# Achsenbeschriftung:
plot(x, xlab= "xAchse", ylab="yAchse")

# Achsen weglassen
# hier nur die punkte: wichtig wenn ich eine zweite Punktreihe in einen bestehenden Plot reinsetz
plot(x, axes=F)

# nur eine Achse automatisch beschriften:
plot(x, xaxt="no")
plot(x, yaxt= "no")

#Achsen selbst beschriften - Punkte raussuchen und dann beschriften
# axis macht was dazu: 1-4 unten, links, oben, rechts
plot(x, xaxt= "no")
axis(1, at=c(1.5, 13.78, 33.34),
     labels=c("was", "auch", "immer"))

# zusätzlicher Text mit mtext
# side is wieder unten, links, oben, rechts, und line is der Abstand (1 is ganz nah)
plot(0:10, ylab="values")
axis(3, at= c(1.5, 3.78, 6.34),
     labels= c("a", "x","z"))
mtext(text ="Additional Label", side =3, line=3)

#Farben und Liniendicke (lwd)
axis(4, col="antiquewhite3", col.axis="seagreen1", lwd=3)

# zusätzliche Achseninfos
axis(2, line=2, at=c(0,10), 
     labels= c("min","max"))

# mehrere Infos unterschiedlich skaliert in einem Plot:
x<- runif(10, 0, 10)   # ohne seed - random 10 Werte zwischen 0 und 10
y <- runif(10, 0, 1)

# Plot 1 bis 10, Linien
plot(1:10, x, type ="l", ylim= c(0,10))

# y-Werte hochskaliert im gleichen Plot
# aber da brauch ich neue Achse
lines(1:10, 10*y, col= 2)
axis(4, at=seq(0,10, by=2),
      labels= seq(0,1, by=0.2))

#Achsenbeschriftung umdrehen, schräg schreiben usw.
plot(x)
plot(x, las=1) 
plot(x, las=2)
plot(x, las=3)

# Rahmen weglöschen (gilt nur für den aktuellen Plot):
plot(x, frame.plot = F)

# Punkte und Symbole
# Punkttypen aussuchen
x<- 1:25
plot(x, pch=1:25)
plot(1:10, pch= 2)
points(rep(5,10), pch=4)

# Linientypen lty, mit Lines extra Linie in Plot gemalt
plot(x, type="l", lty=4)
lines(2*x, lty=5)

# Punktstärke 1 bis 3
x<- 1:25
plot(x, lwd=1:3)

#dicke Strichellinie
plot(x, type="l", lty=2,lwd=3)

# 10 bunte Punkte
plot(x, col=1:10)

# Umrandung is immer 3(Grün) und die innenFarbe is 1:10
plot(x, bg=1:10, pch=22, col=3)

# Größe mit cex-Parameter
plot(x, cex=1:5)

plot(x, cex=3, cex.axis=2, cex.lab=4, 
     cex.main=5, main="Mein Titel")

###############################################################
#
#  anderes plotten
#
###############################################################

# 2 Werte gegeneinander plotten
x <- 10:20
y<-x^2
plot(x,y,type="o")

f <- factor(c(rep("A", 20), rep("B",5),
              rep("C",39)))
table(f)
plot(f, col=3)
plot(f, col=1:3)

# Ich mach einen Dataframe aus Zufallswerten, mit binomialverteilten Werten
df <- data.frame(
  h=runif(10,130,180),
  w= runif(10,50, 110),
  s=(factor(rbinom(10,1,0.5)))
)

plot(df)
# 2 Spalten aus dem df gegeneinander plotten
plot(df$h, df$w)

# Histogram
hist(df$h)

# Histogramm anpassen- density schraffiert abstand und angle winkel
hist(df$h, density=c(3,8),
     angle= c(75, 30))


# Boxplot
boxplot(df$h)
boxplot(df$h, col="blue", border="green")

# WICHTIG FÜR DIE HÜ:
#' FEHLERBALKEN'

x <- 1:10
y <- rnorm(10, mean=50, sd=3)
yHigh <- y + abs(rnorm(10, sd=1))
yLow <- y - abs(rnorm(10, sd=1))
plot(x,y)

# ich brauch Abstand in meinem Plot für meine Fehlerbalken:
plot(x,y, ylim=c(min(yLow), max(yHigh)))

#Fehlerbalkenfunktion
arrows(x, yHigh, x, yLow,
       col=2,
       angle=90,
       length=0.1,
       code=3)

###################################
#
#   Matrix plot
#
###################################

# Barplot mit Matrix

barplot(c(1,4,6), names= letters[1:3])
m<- matrix(1:6, ncol=2)
par(mfrow= c(1,2))
# gestacked
barplot(m, names=letters[1:2], main="not beside")
#nebeneinander
barplot(m, beside= T, names=letters[1:2], main="beside")

# Horizontaler Barplot für Matrizen
barplot(m, beside=T,
        density= c(10, 20, 40),
        angle= c(20, 130, 80),
        col=1:3,
        horiz = T,
        main= "horizontal")



# es wird abgeraten vom Tortendiagramm
pie(c(1,5,3,13), labels= letters[1:4])


par(mfrow=c(1,1))

# Legende
v <- c(5,10, 2)
barplot(v,col=1:3)
legend("topright",
       legend= paste("c", 1:3, sep=""),
       col=1:3,
       lwd=3,
       title ="legend",
       title.col=2)


##################
#
#  expressions
#
#################

# Hochstellen mit den expressions und tiefstellen 

v <- 10^(1:7)
l <- c(expression(10^1,10^2,10^3,10^4,10^5,10^6,10^7))
plot(v, log="y", yaxt= "no")
axis(2, at=v, labels=l, las=1)

legend("topleft", pch=1,
       legend=expression(10^alpha))

# ich brauche für superscript und subscript "Anker", das mach ich mit ""
plot(0:5, type='n',
     xlab= expression(paste(Greek, ",", ""^Superscript, " ", and, ""[Subscript], " ",
                            Expressions, sep="")))

# eine Funktion: die macht zufallszahl zwischen 1 und 4
m_f <- function(){
  return(runif(1,1,4))
}

e <- c(expression(Delta[alpha],
                  Omega^beta,
                  gamma,
                  delta))


# text um text zu plotten (xWert, yWert, welcher text geplotet wird)
for (i in e){
  text(m_f(), m_f(), i)
}

# für jedes element i in meinen Expressions, machts Zufallszahl für x und Zufallszahl
# für y 


v <- log(1:10)
m <- mean(v)
md <- median(v)
barplot(v, names.arg= letters[1:10])
# x-werte und y-werte der Linie ist c(m,m)
# 0,15 sind die x werte und y werte sind beide die m(Mittelwert
# Linie zwischen 0 mittelwert und 15 Mittelwert)
lines(c(0,15), c(m,m), lty=2, lwd=2, col=2)
# median:
lines(c(0,15), c(md,md), lty=3, lwd=2, col=3)

legend("topleft",
       legend= c("mean", "median"),
       col=c(2,3),
       lwd=2,
       lty= c(2,3),
       cex=0.8)

##########################
#
#   Plots exportieren
#
#########################


# wir wollen die plots wo anders abspeichern:
# drei schritte: öffnen - plotten - schliessen!!

#ÖFFNEN
# geöffnet ohne dass man sie sieht - nur im ram da
# jpeg, bmp, png, tiff - Pixelgrafiken
# postscript (.eps), svg, cairo_ps - Vektorgrafiken - da sind nur die Verhältnisse wichtig
# oder pdf (.pdf)

jpeg("filename.jpg", width= 800,
     height=600,
     res=150)

# MACHEN
# dieses par gilt nur für dieses jpeg!!!
par(mfrow=c(2,1))
# es wird direkt in das jpeg geplotet und nicht in mein window
plot(1:10)
lines(10:1)
plot(1:100)

#SPEICHERN
# speichern und schließen
dev.off()



###################################################
#
# EMPFEHLUNG: R-Graph Gallerie
#
###################################################
#############################################################
#########################################################################
#
#
#       PACKAGES
#
#
#########################################################################
#
# Funktionssammlung zu einem Thema
#
# rechts: packages: user Library vs system Library
#
# install.packages("NAME")
#
# dev.tools stellt alles bereit um package zu bauen
# roxygen für Dokumentation

# file -> new project -> new directory -> R package ->





