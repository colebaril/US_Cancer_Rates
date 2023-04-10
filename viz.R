library(tidyverse)
library(here)
library(janitor)
library(usmap)


df <- read_csv("Raw/data-table.csv") %>% 
  clean_names() %>% 
  select(-"url") %>% 
  drop_na()


# VIRIDIS ----

plot_usmap(data = na.omit(df), values = "rate", color = "black") +
  scale_fill_viridis_c("Deaths per \n100,000 Pop",
                       direction = -1) +
  facet_wrap(~year) +
  theme(legend.position = c(.8, 0.05),
        legend.key.size = unit(0.9, "cm")) +
  labs(title = "Number of Cancer Deaths per 100,000 people in the United States",
       subtitle = "For years for which data is available from the CDC",
       caption = "Viz: Cole Baril - colebaril.ca | Data: CDC | Software: R")


# RED ----

plot_usmap(data = na.omit(df), values = "rate", color = "black") +
  scale_fill_continuous("Deaths per \n100,000 Pop", low = "white", high = "firebrick") +
  facet_wrap(~year) +
  theme(legend.position = c(.8, 0.05),
        legend.key.size = unit(0.9, "cm")) +
  labs(title = "Number of Cancer Deaths per 100,000 people in the United States",
       subtitle = "For years for which data is available from the CDC",
       caption = "Viz: Cole Baril - colebaril.ca | Data: CDC | Software: R")


