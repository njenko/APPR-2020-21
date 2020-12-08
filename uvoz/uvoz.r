# 2. faza: Uvoz podatkov


# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.indekse <- function(tabelaIndeksov) {
  data <- read_csv2(tabelaIndeksov, col_names = TRUE,
                    locale=locale(encoding="Windows-1250"))
  
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.indekse("podatki/AEX Index.csv")



# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.
