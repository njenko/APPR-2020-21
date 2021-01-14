# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
                             #pot.zemljevida="OB", encoding="Windows-1250")
# Če zemljevid nima nastavljene projekcije, jo ročno določimo
#proj4string(zemljevid) <- CRS("+proj=utm +zone=10+datum=WGS84")

#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  #{ gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))

# Izračunamo povprečno velikost družine
#povprecja <- druzine %>% group_by(obcina) %>%
  #summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))

ggplot(data=skupnaTabela %>% filter(Measurement_Type == "Growth", Name %in% c("NYSE", "NASDAQ", "N225", "FTSE", "SSE", "AEX", "TSX",  "DAX", "ASX", "IBOVESPA")), aes(x=Date, y=Measurement, color=Name)) + geom_line()

ggplot(data=skupnaTabela %>% filter(Measurement_Type %in% c("Open", "High", "Low"), Name == "NYSE"), aes(x=Date, y=Measurement, fill = Measurement_Type)) + geom_col(position = "dodge")


Mapa_sveta <- map_data("world") %>% select(c(1:5))

zemljevid_rasti <- right_join(svetovna_rast, Mapa_sveta, by = "region")

cplot <- ggplot(zemljevid_rasti, aes(x =long,y= lat, group = group, fill=Measurement))+  
  geom_polygon(color="red") + 
  theme_void() + coord_equal() + labs(fill="Vrednost tržne kapitalizacije") + 
  theme(legend.position="bottom")


cplot


