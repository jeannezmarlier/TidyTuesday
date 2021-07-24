library(tidyverse)
library(viridis)

drought <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-07-20/drought.csv')
drought <- drought[ (drought$drought_lvl %in% c("D2", "D3", "D4")), ]


drought_west <- drought[ (drought$state_abb %in% c("WA", "OR", "CA", "MT", "ID", "NV", "WY", "UT", "CO", "AZ", "NM")), ]
drought_south <- drought[ (drought$state_abb %in% c("TX", "OK", "AR", "LA", "MS", "AL", "GA", "FL", "SC", "NC", "TN", "KY", "WV", "VA", "DC", "MD", "DE")), ]

plot_west <- ggplot(drought_west, aes(x=valid_end, y=reorder(state_abb, area_pct), fill=area_pct)) + 
  
  geom_tile() +
  scale_fill_viridis(option = "inferno", limits=c(0,100)) +
  
  labs(y ="",
       x = "",
       title = "Percent of state in severe, extreme or exceptional drought, 2001-2021\n",
       subtitle = "WEST") +
  
  theme_minimal() +
  
  theme(
    panel.grid = element_blank(),
    plot.margin = margin(t = 0.7, r = 0.5, b = 0.5, l = 0.5, unit = "cm"),
    panel.background = element_rect(fill = "#F0F0F0", color = "#F0F0F0"),
    plot.background = element_rect(fill = "#F0F0F0"),
    legend.position="none",
    legend.title = element_blank(),
    axis.text.x = element_text(family="Chivo", size = 15, color="#444444"),
    axis.text.y = element_text(family="Chivo", size = 16, color="#1E1E1E"),
    plot.title = element_text(family="Chivo", face="bold", size=20, color="#1E1E1E", hjust=0.5),
    plot.subtitle = element_text(family="Chivo", size = 14, color="#1E1E1E", hjust=0.5)) 

plot_south <- ggplot(drought_south, aes(x=valid_end, y=reorder(state_abb, area_pct), fill=area_pct)) + 
  
  geom_tile() +
  scale_fill_viridis(option = "inferno", limits=c(0,100)) +
  
  labs(y ="",
       x = "",
       subtitle = "SOUTH",
       caption = "\nData : U.S. Drought Monitor | #TidyTuesday | @j_marlier") +
  
  theme_minimal() +
  
  theme(
    panel.grid = element_blank(),
    plot.margin = margin(t = 0.7, r = 0.5, b = 0.5, l = 0.5, unit = "cm"),
    panel.background = element_rect(fill = "#F0F0F0", color = "#F0F0F0"),
    plot.background = element_rect(fill = "#F0F0F0"),
    legend.position="bottom",
    legend.title = element_blank(),
    legend.text = element_text(family="Chivo", size = 10, color="#444444"),
    axis.text.x = element_text(family="Chivo", size = 15, color="#444444"),
    axis.text.y = element_text(family="Chivo", size = 16, color="#1E1E1E"),
    plot.subtitle = element_text(family="Chivo", size = 14, color="#1E1E1E", hjust=0.5),
    plot.caption = element_text(family="Chivo", size = 8, hjust=0.5, color="#444444")
  ) 

plot <- plot_west / plot_south

ggsave(filename = "plot_drought.png", plot = plot, width = 14, height = 12)
