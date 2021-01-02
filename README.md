# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/njenko/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/njenko/APPR-2020-21/master?urlpath=rstudio) RStudio

## Analiza borznih indeksov

Analiziral bom borzne indekse desetih velikih svetovnih borz (TSX, NYSE, NASDAQ, DAX, AEX, SSE, IBOVESPA, N225, ASX, SBITOP). Zanimala me bo rast indeksov gelde na časovno obdobje in rast v primerjavi z ostalimi borzami. Ker so borze izbrane na različnih koncih sveta, lahko podatke vizualiziram tudi z zemljevidom. 
V tabelah bo do za vsako borzo mesečni podatki o indeksu ob odprtju, indeksu ob zaprtju, najvišji indeks v mesecu in najnižji indeks v mesecu. Te tabele bom potem združil v eno, kjer je ime borze še ena spremenljivka. 

Tabele:
  * Informacije za posamezno borzo:
    * indeks ob odprtju
    * najvišji indeks
    * najnižji indeks
    * indeks ob zaprtju
    * volumen
    
  * Tabela vseh borz:
    * Ime borze
    * Lokacija borze
    
  * Dogodki v letu 2020:
    * Datum
    * Dogodek
    

Viri podatkov: 
  * TSX(Toronto, Canada): https://ca.finance.yahoo.com/quote/%5EGSPTSE/history?p=%5EGSPTSE
  * NYSE(New York, USA): https://finance.yahoo.com/quote/%5ENYA/history?p=%5ENYA
  * NASDAQ(New York, USA): https://finance.yahoo.com/quote/%5EIXIC/history?p=%5EIXIC
  * DAX(Frankfurt, Germany): https://finance.yahoo.com/quote/%5EGDAXI?p=%5EGDAXI
  * AEX(Amsterdam, Netherlands): https://finance.yahoo.com/quote/^AEX?p=^AEX&.tsrc=fin-srch
  * SSE(Shanghai, China): https://finance.yahoo.com/quote/000001.SS/history?p=000001.SS
  * IBOVESPA(Sao Paolo, Brasil): https://finance.yahoo.com/quote/^BVSP?p=^BVSP&.tsrc=fin-srch
  * N225(Osaka, Japan): https://finance.yahoo.com/quote/^N225?p=^N225&.tsrc=fin-srch
  * ASX(Sidney, Australia): https://finance.yahoo.com/quote/%5EAXJO/history?p=%5EAXJO
  * FTSE 250(London, United Kingdom): https://finance.yahoo.com/quote/%5EFTMC%3FP%3D%5EFTMC/history/
  
## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `tmap` - za izrisovanje zemljevidov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-202021)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
