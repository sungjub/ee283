# Downloading the rawdata in my local computer (window) 
rawdata = "C:/Users/Sungjun/Desktop/EE283/Week8_R-Data-Science/rawdata/allhaps.malathion.200kb.txt.gz"
url="http://wfitch.bio.uci.edu/~tdlong/allhaps.malathion.200kb.txt.gz"
download.file(
  url, 
  destfile = rawdata,
  method = "auto",
  mode = "wb")

# load libraries
library(tidyverse)
library(dplyr)
library(broom)

# read the file
mal <- read_tsv(rawdata)

# ---------------------Hint-Code---------------------

# check the file
head(mal)
str(mal)

# select the first position in the genome
# this can be used to test different "models"
mal2 = mal %>% filter(chr=="chrX" & pos==316075)

# changing the data type to factors
levels(as.factor(mal2$pool))
levels(as.factor(mal2$founder))	

# this is to fit the model on the given location (pos - 316075) 
mal2 = mal2 %>% mutate(treat=str_sub(pool,2,2))

# check unique values of the "treat" column
unique(mal2$treat)

# fitting the model 
anova(lm(asin(sqrt(freq)) ~ treat + founder + treat:founder, data=mal2))

# the homework1 is to fit this model to:
# every location in the genome 

# ---------------------Homework_1---------------------

# writing a function to fit the model 
myModel_1 <- function(df){
  # this is to get the -logp value per grouped data
  out = anova(lm(asin(sqrt(freq)) ~ treat + founder + treat:founder, data=df))
  # extracting the p-values from treat:founder Pr(>F) - the p-value for this test
  myF = -log10(out[3,5])
  # returning the myF variable value for each input
  myF
}

# writing a function to fit the model 
myModel_2 <- function(df){
  # this is to get the -logp value per grouped data
  out = anova(lm(asin(sqrt(freq)) ~ founder + treat %in% founder, data=df))
  # extracting the p-values from treat:founder Pr(>F) - the p-value for this test
  myF = -log10(out[2,5])
  # returning the myF variable value for each input
  myF
}

# adding the "treat" column 
mal = mal %>% mutate(treat=str_sub(pool,2,2))

# changing the data types
mal$chr <- as.character(mal$chr)
mal$pool <- as.character(mal$pool)
mal$founder <- as.factor(mal$founder)
mal$treat <- as.factor(mal$treat)

# checking the data
head(mal)
str(mal)

# creating "myResult_1" table
myResult_1 <- mal %>%
  # getting rid of NA in the dataframe
  # na.omit() %>%
  group_by(chr, pos) %>%
  nest() %>%
  mutate(p.value = map_dbl(data, myModel_1))
  # this function is now unnecessary because "myMod" does not include a summary statistics but a single p.value that I am interested in
  # mutate(myGlance = map(myMod, broom::glance))

# creating "myResult_2" table
myResult_2 <- mal %>%
  # getting rid of NA in the dataframe
  # na.omit() %>%
  group_by(chr, pos) %>%
  nest() %>%
  mutate(p.value = map_dbl(data, myModel_2))
  # this function is now unnecessary because "myMod" does not include a summary statistics but a single p.value that I am interested in
  # mutate(myGlance = map(myMod, broom::glance))
  # this table gives

# Combining the two tables into one
# adding "model" column 

myResult_1 <- myResult_1 %>%
  mutate(model = "myModel_1")

myResult_2 <- myResult_2 %>%
  mutate(model = "myModel_2")

myResult_merged <- rbind(myResult_1, myResult_2)
