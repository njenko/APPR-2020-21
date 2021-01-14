# 2. faza: Uvoz podatkov

library(dplyr)
library(readr)
library(tidyr)
library(rvest)
# Funkcija, ki uvozi podatke iz datotek z indeksi borz v formatu csv, ker so podatki loceni z vejico uporabimo read_csv in ne read_csv2
# dodamo vrstico z imenom broze, da lahko nato tabele združimo v eno
# odrežemo zadnjo vrstico
uvozi.indekse <- function(tabelaIndeksov, kraticaBorze) {
  data <- read_csv(tabelaIndeksov, col_names=TRUE,
                    locale=locale(encoding="Windows-1250")) %>% 
    mutate(Name = kraticaBorze, Growth = 100 * (Close - Open) / Open) %>%
  slice(-13) 
  data <- data[c(1, 8, 2, 3, 4, 5, 6, 7, 9)]
  data <- data[c(-7)]
  return(data)
}


uvozi.borze <- function() {
  url <- "https://en.wikipedia.org/wiki/List_of_stock_exchanges"
  stran <- read_html(url)
  html_tabela <- stran %>%
    html_nodes(xpath="//table[@class='wikitable sortable']") %>% .[[1]]
  tabela <- html_tabela %>% html_table(dec=".", fill = TRUE)
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  
  colnames(tabela) <- c("1", "2", "Borza","Name", "region", "Kraj",
                        "Market_cap", "Monthly_volume",
                        "3", "4", "5", "6", "7",
                        "8", "9", "10")
  
  #Izbira pravilnih podatkov
  tabela <- tabela %>% select(3, 4, 5, 6, 7, 8) %>% slice(c(1, 2, 3, 4, 5, 7, 8, 12, 24, 26))
  
  #Preimenovanje simbolov
  simboliBorz = c("NYSE", "NASDAQ", "N225", "FTSE", "SSE", "AEX", "TSX",  "DAX", "ASX", "IBOVESPA")
  tabela <- tabela %>% mutate(Name = simboliBorz)
  
  #tabela
  vrstice <- html_tabela %>% html_nodes(xpath=".//tr") %>% .[-1]
  borze <- vrstice %>% html_nodes(xpath="./td[3]") %>% html_text()
  kraji <- vrstice[1:14] %>% html_nodes(xpath="./td[6]") %>% lapply(. %>% html_nodes(xpath="./a") %>% html_text())
  borze.kraji <- data.frame(borza=lapply(1:length(kraji),
                                         . %>% { rep(borze[.], length(kraji[[.]])) }) %>% unlist(),
                            kraj=unlist(kraji))

  tabela$Market_cap <- as.numeric(gsub(",",".",tabela$Market_cap))
  tabela$Monthly_volume <- as.numeric(gsub(",",".",tabela$Monthly_volume))
  
  return(tabela)
}

seznamBorz <- uvozi.borze()

TSX <- uvozi.indekse("podatki/S&P-TSX Composite index.csv", "TSX")
NYSE <- uvozi.indekse("podatki/NYSE Composite.csv", "NYSE")
NASDAQ <- uvozi.indekse("podatki/NASDAQ Composite.csv", "NASDAQ")
DAX <- uvozi.indekse("podatki/DAX Performance Index.csv", "DAX")
AEX <- uvozi.indekse("podatki/AEX Index.csv", "AEX")
SSE <- uvozi.indekse("podatki/SSE Composite Index.csv", "SSE")
IBOVESPA <- uvozi.indekse("podatki/IBOVESPA.csv", "IBOVESPA")
N225 <- uvozi.indekse("podatki/Nikkei 225.csv", "N225")
ASX <- uvozi.indekse("podatki/S&P-ASX 200.csv", "ASX")
FTSE <- uvozi.indekse("podatki/FTSE 250.csv", "FTSE")


skupnaTabela <- bind_rows(NYSE, NASDAQ, N225, FTSE, SSE, AEX, TSX,  DAX, ASX, IBOVESPA)

#spremenimo v obliko tidy data

skupnaTabela <- skupnaTabela %>% pivot_longer(c(-Date, -Name), names_to="Measurement_Type", values_to="Measurement")

svetovna_rast <- full_join(seznamBorz, skupnaTabela %>% filter(Measurement_Type == "Growth"), by = "Name")