# 3. faza: Vizualizacija podatkov

library(ggplot2)


graf1 <- ggplot(data=skupnaTabela %>% filter(Measurement_Type == "Growth", Name %in% c("NYSE", "NASDAQ", "N225", "FTSE", "SSE", "AEX", "TSX",  "DAX", "ASX", "IBOVESPA")), aes(x=Date, y=Measurement, color=Name)) + geom_line()

graf2 <- ggplot(data=skupnaTabela %>% filter(Measurement_Type %in% c("Open", "High", "Low"), Name == "NYSE"), aes(x=Date, y=Measurement, fill = Measurement_Type)) + geom_col(position = "dodge")

graf3 <- ggplot(data=skupnaTabela %>% filter(Measurement_Type == "Volume", Date == "2020-01-01"), aes(x=Name, y=Measurement)) + geom_col()

grafMapa_sveta <- map_data("world") %>% select(c(1:5))

zemljevid_rasti <- right_join(svetovna_rast  %>% filter(Date == "2020-03-01"), Mapa_sveta, by = "region")

svetovna_rast$region <- gsub(svetovna_rast$region[37:48], "UK", svetovna_rast$region)
svetovna_rast$region <- gsub("United States", "USA", svetovna_rast$region)

cplot <- ggplot(zemljevid_rasti, aes(x =long,y= lat, group = group, fill=Measurement))+  
  geom_polygon(color="white") + 
  theme_void() + coord_equal() + labs(fill="Growth") + 
  theme(legend.position="bottom")


cplot


