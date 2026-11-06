library(tidyverse)

daten <- read_csv("data/betriebsdaten.csv")
library(tidyverse)  
install.packages(c("readxl", "tidyverse"))

library(readxl)
library(tidyverse)
datenschuhgroesse <- read_csv("data/schule_schuhgroessen.csv")
datenschuhgroesse <- read_excel("data/schule_schuhgroessen.xlsx", sheet = "Daten")
# man muss csv2 verwenden weil die Daten in der Excel Datei Deutsch formatirt sind (./,)
datenschuhgroesse <- read_csv2("data/schule_schuhgroessen.csv")
