# Antwort: Welche Inhalte der 3. Klasse lassen sich mit R effizienter lösen?

## 1. Kurzthese

R lohnt sich überall dort, wo **viele gleichartige Rechenschritte** anfallen,
wo **exakte Werte aus Verteilungen** gebraucht werden (statt grober Tabellen)
und wo **Ergebnisse dargestellt, variiert oder dokumentiert** werden müssen.
Kein Effizienzvorteil entsteht beim **Verstehen der Konzepte**, beim
**Herleiten von Formeln** und bei **einmaligen Kopfrechnungen**.

Merksatz: *R ersetzt das Rechnen, nicht das Denken.*

## 2. Effizienzkriterien

| Kriterium | Handrechnung | R |
|-----------|--------------|---|
| Anzahl Rechenschritte | wenige, aber fehleranfällig | beliebig viele, automatisiert |
| Verteilungs-Werte | Tabelle, Zwischenwerte geraten | exakt über `p`/`q`-Funktionen |
| Wiederholung / Varianten | jedes Mal neu | Schleife/Funktion/Simulation |
| Darstellung | Excel-Diagramm, mühsam | `ggplot2`, in Code reproduzierbar |
| Dokumentation | lose Zettel | Quarto/Markdown, reproduzierbar |

## 3. Zuordnung der Inhalte zu R

### KM5 (5. Semester)

| Inhalt | Klassisch | R | Effizienz |
|--------|-----------|---|-----------|
| Zufallsvariablen, Wahrscheinlichkeiten | Tabellen | `pnorm`, `pbinom`, `dpois` | hoch |
| Diskrete Verteilungen (Binomial, Hypergeometrisch, Poisson) | Formeln | `dbinom`/`pbinom`, `dhyper`/`phyper`, `dpois`/`ppois` | hoch |
| Normalverteilung, Standardisierung, 68-95-99,7 | z-Tabelle | `pnorm`, `qnorm`, `scale()` | hoch |
| Exponentialverteilung | Formel | `pexp`, `qexp`, `dexp` | hoch |
| Lage- und Streumaße | Hand/Excel | `mean`, `median`, `sd`, `var`, `IQR`, `summary` | mittel–hoch |
| Parameter vs. Schätzwerte (Bessel n−1, GGZ) | Formel | `var`, Simulation mit `replicate` | mittel |

### KM6 (6. Semester)

| Inhalt | Klassisch | R | Effizienz |
|--------|-----------|---|-----------|
| Standardfehler, KI für μ | Formel + z-Tabelle | `t.test()$conf.int`, `qt` | hoch |
| KI bei unbekanntem σ (t-Verteilung) | t-Tabelle | `t.test`, `qt(0.975, df)` | hoch |
| KI für σ² | χ²-Tabelle | `qchisq` | hoch |
| Prüfergebnisse darstellen (Histogramm, Boxplot, QQ, Scatter) | Excel-Diagramme | `ggplot2` + Quarto | **sehr hoch** |
| Kennzahlen und Ausreißer (1,5·IQR) | von Hand | `IQR`, `quantile`, `boxplot.stats` | hoch |
| Lebensdauerverteilungen, Weibull, MTBF/MTTF | Weibull-Papier/Numerik | `fitdistrplus`, `pweibull`, `gamma()` | hoch |

## 4. Beispiele mit R-Code

### Beispiel A — Normalverteilung statt z-Tabelle (KM5)

```r
# P(X <= 110) bei mu = 100, sigma = 15
pnorm(110, mean = 100, sd = 15)            # 0.7475

# 95%-Quantil: welcher Wert wird mit 95% Wahrscheinlichkeit nicht überschritten?
qnorm(0.95, mean = 100, sd = 15)           # 124.67

# 68-95-99,7-Regel prüfen
pnorm(1) - pnorm(-1)                       # 0.6827
pnorm(2) - pnorm(-2)                       # 0.9545
pnorm(3) - pnorm(-3)                       # 0.9973
```

Statt in der z-Tabelle nachzuschlagen und zu interpolieren, liefert R den
exakten Wert – und beliebig viele Werte auf einmal.

### Beispiel B — Konfidenzintervall für den Mittelwert (KM6)

```r
# Messreihe (z. B. Prüfergebnisse)
x <- c(12.1, 11.8, 12.4, 11.9, 12.2, 12.0, 11.7, 12.3)

# 95%-KI für mu (t-Verteilung, sigma unbekannt)
t.test(x, conf.level = 0.95)$conf.int
# [1] 11.83868 12.23632

# Falls sigma bekannt waere: KI direkt mit z = 1.96
n <- length(x); sigma <- 0.3
mean(x) + c(-1, 1) * qnorm(0.975) * sigma / sqrt(n)
```

Das `t.test()` liefert neben dem KI auch Schätzwert, t-Statistik und
p-Wert – alles in einer Zeile.

### Beispiel C — Ausreißer nach der 1,5·IQR-Regel (KM6)

```r
werte <- c(3, 4, 5, 5, 6, 7, 8, 25)

quantile(werte, c(0.25, 0.50, 0.75))   # Q1, Median, Q3
IQR(werte)                             # Interquartilsabstand
boxplot.stats(werte)$out               # erkennt 25 als Ausreißer
```

### Beispiel D — Lebensdauer: Weibull anpassen und MTTF (KM6)

```r
library(fitdistrplus)
daten <- c(120, 180, 210, 260, 300, 340, 420, 510)

fit  <- fitdist(daten, "weibull")
beta <- fit$estimate["shape"]   # Formparameter
eta  <- fit$estimate["scale"]   # Skalenparameter

# MTTF = eta * Gamma(1 + 1/beta)
mttf <- eta * gamma(1 + 1 / beta)
mttf
```

Die Anpassung der Weibull-Verteilung ist von Hand praktisch nicht machbar –
hier ist R klar überlegen.

## 5. Wo R kaum hilft

- **Konzeptverständnis:** Was ist eine Dichte, was eine Verteilungsfunktion?
  Das muss man verstehen, nicht berechnen.
- **Herleitungen:** z-Transformation, Bessel-Korrektur, KI-Formel – die Logik
  dahinter erschließt sich nicht aus dem Code.
- **Modellannahmen prüfen:** Ob die Normalverteilung überhaupt passt, ist eine
  fachliche Entscheidung.
- **Einzelne Kopfrechnungen:** Für einen einzigen Wert lohnt der Umweg über R
  nicht.
- **Datenqualität:** Fehlende Werte, Ausreißer durch Messfehler – hier ist
  Urteilsvermögen gefragt, nicht Rechenleistung.

## 6. Fazit

Am größten ist der Nutzen von R bei **Verteilungsrechnungen, Vertrauens-
bereichen, der Darstellung von Prüfergebnissen und den Lebensdauer-
verteilungen** – also überall dort, wo Tabellen, Wiederholung und
Visualisierung zusammenkommen. Beim **Verstehen der Begriffe und beim
Herleiten der Formeln** bleibt R nutzlos. Insgesamt gilt: R verschiebt die
Arbeit vom **mühsamen Rechnen** hin zum **richtigen Interpretieren** der
Ergebnisse – genau das soll die 3. Klasse in der Qualitätssicherung können.
