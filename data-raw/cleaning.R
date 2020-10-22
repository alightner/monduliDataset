require(readr)
require(dplyr)
require(devtools)
require(usethis)
d <- read_csv('data-raw/anonymized-dataset.csv')
df <- 
  d %>% 
  mutate(
    roof2 = case_when(
      roof=='metal' ~ 1,
      TRUE ~ 0
    ),
    wealth = roof2+wives_cowives+solar
  ) %>% 
  rowwise() %>% 
  mutate(
    sum_dep = sum(c_across(livestock_manage:teaching))
  ) %>% 
  ungroup() %>% 
  mutate(
    depend = livestock_manage/sum_dep
  ) %>% 
  dplyr::select(
    id,
    trust=trust_vignette01,
    check=trust_vignette_verify,
    condition=trust_vignette_condition,
    insecure=food_insecurity,
    need=hh_need2,
    wealth=wealth,
    depend,
    purchases_market:sheep,
    roof=roof2,
    solar,
    region
  ) %>% 
  mutate(
    purchases_market=as.numeric(factor(purchases_market, levels=c(
      'never', 'rarely', 'sometimes', 'often', 'very often'
    ))),
    cell_use=as.numeric(factor(cell_use, levels=c(
      'never', 'sometimes', 'often'
    ))),
    education=as.numeric(factor(education, levels=c(
      'none', 'primary', 'secondary'
    ))),
    urban_travel=as.numeric(factor(urban_travel, levels=c(
      'never', 'rarely', 'sometimes', 'often', 'very often'
    ))),
    christian=as.numeric(factor(christian, levels=c(
      'traditional', 'christian'
    ))),
    rituals_frequency=as.numeric(factor(rituals_frequency, levels=c(
      'never', 'rarely', 'sometimes', 'often', 'very often'
    ))),
    prayer_frequency=as.numeric(factor(prayer_frequency, levels=c(
      'never', 'rarely', 'when in need', 'sometimes', 'often'
    ))),
    disagree_god_frequency=as.numeric(factor(disagree_god_frequency, levels=c(
      'never', 'rarely', 'sometimes', 'often', 'very often'
    )))
  )


# verify anonymity here ------------------------------------------------
## data about (lack of) identifiability stored in sdc object
## uncomment and run source line below to view
## this can be run before and after the cleaning script has been run
# source('data-raw/anon-check.R')

# name and write data files, clean env ------------------------------------
dataset <- df
usethis::use_data(dataset, overwrite=TRUE)

rm(list=ls(all=TRUE))
