library(noncensus)
data(zip_codes)
data(counties)

state_fips  = as.numeric(as.character(counties$state_fips))
county_fips = as.numeric(as.character(counties$county_fips))
counties$fips = state_fips*1000+county_fips
zip_codes$fips =  as.numeric(as.character(zip_codes$fips))

# test
temp = subset(zip_codes, zip == "80535")
subset(counties, fips == temp$fips)
