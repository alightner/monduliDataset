library(sdcMicro)
df$region <- as.factor(df$region)
df$gender <- as.factor(df$gender)
df$weight <- 100

d <- df %>% 
  select(
    region,
    clan,
    gender,
    age,
    wives_cowives,
    num_children,
    education,
    hh_size,
    christian,
    cattle,
    goats,
    donkeys,
    sheep,
    chickens,
    roof,
    solar,
    weight
  )

cnames <- sapply(d, function(x) (class(x)=='character') | (class(x)=='factor'))
sdc <- createSdcObj(d, keyVars=colnames(d)[cnames], numVars=colnames(d)[!cnames], w='weight')

# Number of observations violating
# - 2-anonymity: 0 (0.000%)
# - 3-anonymity: 0 (0.000%)
# - 5-anonymity: 0 (0.000%)

