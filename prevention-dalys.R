## Think piece for prevention

library(pacman)
p_load(tidyverse)

setwd("~/Downloads")

dalys <- read_csv("download (38).csv") %>% mutate(metric = "dalys")
yld <- read_csv("download (39).csv") %>% mutate(metric = "yld")
deaths <- read_csv("download (40).csv") %>% mutate(metric = "deaths")

dalys_cvd <- read_csv("download (41).csv") %>% mutate(metric = "dalys")
yld_cvd <- read_csv("download (42).csv") %>% mutate(metric = "yld")
deaths_cvd <- read_csv("download (43).csv") %>% mutate(metric = "deaths")

dalys_ng <- read_csv("download (44).csv") %>% mutate(metric = "dalys")
yld_ng <- read_csv("download (45).csv") %>% mutate(metric = "yld")
deaths_ng <- read_csv("download (46).csv") %>% mutate(metric = "deaths")


trend <- bind_rows(dalys, yld, deaths)
trend_cvd <- bind_rows(dalys_cvd, yld_cvd, deaths_cvd)
trend_ng <-  bind_rows(dalys_ng, yld_ng, deaths_ng)


trend %>%
  ggplot(aes(Year, Value, lty = metric) ) +
  geom_line(aes(group = metric)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~metric, scales = "free") +
  labs(y = "Rate per 100,000")

trend_cvd %>%
  ggplot(aes(Year, Value, lty = metric) ) +
  geom_line(aes(group = metric)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~metric, scales = "free") +
  labs(y = "Rate per 100,000")

trend_ng %>%
  ggplot(aes(Year, Value, lty = metric) ) +
  geom_line(aes(group = metric)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~metric, scales = "free") +
  labs(y = "Rate per 100,000")        
