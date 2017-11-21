library(tidyverse)
library(openxlsx)
library(readxl)


url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/deathratesandyearsoflifelostforcausesconsideredavoidableamenableandpreventableenglandandwalesandenglishregions/2015/referencetable1final1.xls"

ons <- downloader::download(url, "ons_data.xls")

amenable_cause_table <- read_excel("ons_data.xls", sheet = "Definition",range = "B6:F73" )

ons_data1 <- read_excel("ons_data.xls", sheet = "Amenable",range = "A12:P26" )

amenable_rates <- ons_data1 %>%
  mutate(cause1 = lag(Cause)) %>%
  mutate(Cause = ifelse(is.na(Cause), cause1, Cause)) %>%
  janitor::clean_names()



  
preventable_rates <- read_excel("ons_data.xls", sheet = "Preventable",range = "A12:P28" ) %>%
  mutate(cause1 = lag(Cause)) %>%
  mutate(Cause = ifelse(is.na(Cause), cause1, Cause)) %>%
  janitor::clean_names()
