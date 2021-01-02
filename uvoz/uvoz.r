# 2. faza: Uvoz podatkov

library(dplyr)
library(readr)
# Funkcija, ki uvozi podatke iz datotek z indeksi borz v formatu csv, ker so podatki loceni z vejico uporabimo read_csv in ne read_csv2
# dodamo vrstico z imenom broze, da lahko nato tabele združimo v eno
# odrežemo zadnjo vrstico
uvozi.indekse <- function(tabelaIndeksov, kraticaBorze) {
  data <- read_csv(tabelaIndeksov, col_names = TRUE,
                    locale=locale(encoding="Windows-1250")) %>% 
    mutate(Name = kraticaBorze, Growth = "1") %>%
    slice(-13)
    
    
  data <- data[c(1, 8, 2, 3, 4, 5, 6, 7)]
  return(data)
}

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


skupnaTabela <- bind_rows(TSX, NYSE, NASDAQ, DAX, ASX, SSE, IBOVESPA, N225, ASX, FTSE)