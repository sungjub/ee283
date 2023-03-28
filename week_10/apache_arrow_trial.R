#### Following the Apache Arrow Tutorial

library(tidyverse)
library(arrow)
library(dbplyr, warn.conflicts = FALSE)
library(duckdb)

dir.create("data", showWarnings = FALSE)

curl::multi_download(
  "https://r4ds.s3.us-west-2.amazonaws.com/seattle-library-checkouts.csv",
  "data/seattle-library-checkouts.csv",
  resume = TRUE
)

seattle_csv <- open_dataset(
  sources = "data/seattle-library-checkouts.csv", 
  format = "csv"
)

### checking the data, this is about 9gb worth of data...

seattle_csv

seattle_csv |> 
  count(CheckoutYear, wt = Checkouts) |> 
  arrange(CheckoutYear) |> 
  collect()

