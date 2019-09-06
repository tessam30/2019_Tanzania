# Fetch selected DHS indicators for TZ
# Author: Tim Essam
# Date: 2019_09_05
# Notes: For TZ TDY prep

library(fetchdhs)
library(tidyverse)
library(purrr)
library(tidylog)

# What surveys are available
fetch_surveys() %>% 
    filter(country_name %in% c("Tanzania")) %>% print(n = Inf)


# Select the tags in which you are interested
fetch_tags() %>% print(n = Inf)

fetch_data(countries = "TZ", years = 2002:2019, tag = 8)

# Better yet, return all indicators with stunting in the definition
fetch_indicators() %>% 
  filter(str_detect(definition, "stunt")) %>% 
  select(tag_ids, indicator_id, label)


# Returns a list of values
dhs_api <- 
  fetch_data(
    countries = c("TZ"),
    indicators = c("CN_NUTS_C_HA2"),
    breakdown_level = "subnational"
  )

TZ_dhs <- 
  map_dfr(dhs_api, ~as.data.frame(.)) %>% 
  filter(!is.na(data_id)) %>% 
  mutate(REG_ID = region_id)


# Plot results to see what is consistent across time / space
TZ_dhs %>% 
  ggplot(aes(x = survey_year_label, y = value, group = characteristic_label)) +
  geom_line() + geom_point() +
  facet_wrap(~characteristic_label) +
  theme_minimal()

