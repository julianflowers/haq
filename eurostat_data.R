## Eurostat amenamble mortality

if(!require(eurostat))install.packages("eurostat")
library(eurostat)
library(tidyverse)
library(openxlsx)

## download table of contents
toc <- eurostat::get_eurostat_toc()

am <- search_eurostat("Amenable", type = "dataset")

am_data <- get_eurostat(id = "hlth_cd_apr")
am_data1 <- get_eurostat(id = "hlth_cd_apreu")

summary(am_data1)


write.xlsx(am_data, "eurostat_data.xlsx")
write.xlsx(am_data1, "eurostat_data1.xlsx")


am_data %>%
  filter(unit == "RT", values > 10) %>%
  ggplot(aes(time, values, shape = indic_he, colour = geo, group = geo)) + 
  geom_line() +
  geom_point() +
  facet_wrap(indic_he~icd10, scales = "free", nrow = 2) +
  labs(caption = "Source: EUROSTAT", 
       title = "Preventable and amenable mortality in Europe \n2010-2014")
+
  scale_y_log10()
  

am_data1 %>%
  filter(unit == "RT", values > 10, !icd10 == "TOTAL") %>%
  ggplot(aes(time, values, shape = indic_he, colour = icd10)) + 
  geom_line() +
  geom_point() +
  facet_wrap(indic_he~sex, scales = "free", nrow = 2) +
  labs(caption = "Source: EUROSTAT", 
       title = "Preventable and amenable mortality in Europe \n2010-2014", 
       subtitle = "By ICD10 code", 
       y = "Rate")
+
  scale_y_log10()
