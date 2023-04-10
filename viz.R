library(tidyverse)
library(here)
library(janitor)
library(usmap)
library(plotly)

df <- read_csv("Raw/data-table.csv") %>% 
  clean_names() %>% 
  select(-"url")



plot_usmap(data = na.omit(df), values = "rate", color = "black") +
  scale_fill_viridis_c("Deaths per \n100,000 Pop",
                       direction = -1) +
  facet_wrap(~year) +
  theme(legend.position = c(.8, 0.05),
        legend.title = element_text("Deaths per \n 100,000 Pop"),
        legend.key.size = unit(0.9, "cm")) +
  labs(title = "Number of Cancer Deaths per 100,000 people in the United States",
       subtitle = "For years for which data is available from the CDC",
       caption = "Viz: Cole Baril - colebaril.ca | Data: CDC | Software: R")


