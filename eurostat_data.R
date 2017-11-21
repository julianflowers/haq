## Eurostat amenamble mortality

if(!require(eurostat))install.packages("eurostat")
library(eurostat)
library(tidyverse)

## download table of contents
toc <- eurostat::get_eurostat_toc()

am <- search_eurostat("Amenable", type = "dataset")

am_data <- get_eurostat(id = "hlth_cd_apr")

summary(am_data)

am_data %>%
  filter(unit == "RT", values > 10) %>%
  ggplot(aes(time, values, shape = indic_he, colour = geo, group = geo)) + 
  geom_line() +
  geom_point() +
  facet_wrap(indic_he~sex, scales = "free", nrow = 2) +
  labs(caption = "Source: EUROSTAT", 
       title = "Preventable and amenable mortality in Europe \n2010-2014")
+
  scale_y_log10()
  