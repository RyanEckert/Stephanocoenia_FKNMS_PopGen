library("tidyverse")

setwd("~/Documents/GitHub/FKNMS/lab/")

samples = read.csv("samples.csv")

### Xestospongia
xestoSamples = samples %>% group_by(species, region, depthZone) %>% filter(species == "Xestospongia muta") %>% 
  add_count()

xestoLow = xestoSamples %>% filter(n < 30) %>% as.data.frame()

set.seed(694)
xestoSubset = xestoSamples %>% filter(n >= 30) %>% sample_n(30) %>% as.data.frame() %>% add_row(xestoLow) %>% 
  arrange(sampleID) %>% add_column(tubeID = paste("X", sprintf("%03s", rownames(.)), sep = ""), .after = "sampleID") %>% 
  group_by(region, depthZone) %>% add_count() %>% as.data.frame()

#### Save .csv of subset
write.csv(xestoSubset, "fknmsXestoSubset.csv")

### Stepahnocoenia
sintSamples = samples %>% group_by(species, region, depthZone) %>% filter(species == "Stephanocoenia intersepta") %>% 
  add_count()

sintLow = sintSamples %>% filter(n < 30) %>% as.data.frame()

set.seed(694)
sintSubset = sintSamples %>% filter(n >= 30) %>% sample_n(30) %>% as.data.frame() %>% add_row(sintLow) %>% 
  arrange(sampleID) %>% add_column(tubeID = paste("S", sprintf("%03s", rownames(.)), sep = ""), .after = "sampleID") %>% 
  group_by(region, depthZone) %>% add_count() %>% as.data.frame()

#### Save .csv of subset
write.csv(sintSubset, "fknmsStephanocoeniaSubset.csv")

### Create one large file of species subsets
fknmsSampleSubset = xestoSubset %>% add_row(sintSubset)

write.csv(fknmsSampleSubset, "fknmsSubset.csv")
