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

# CHANGE OVER TIME ----

df %>% 
  select(-deaths) %>% 
  pivot_wider(names_from = year, values_from = rate) %>% 
  rename("y2020" = "2020",
         "y2005" = "2005") %>% 
  mutate(pct_change = (y2020/y2005)*100-100) %>% 
  select(state, pct_change) %>% 
  arrange(pct_change) %>% 
  gt() %>% 
  tab_header(title = "Percent Change in Cancer Mortality",
             subtitle = "2005-2020, per 100,000 Pop") %>% 
  cols_label(
    state = "State",
    pct_change = "Percent Change") %>% 
  cols_align(align = "center",
             columns = everything()) %>% 
  fmt_number(columns = pct_change,
             rows = everything(),
             decimals = 2) %>% 
  tab_footnote("Created by Cole Baril - colebaril.ca | Data: CDC | Software: R") %>% 
  gtsave("pct_change.html")


