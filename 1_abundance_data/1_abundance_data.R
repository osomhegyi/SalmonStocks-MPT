## load R packages
library(tidyverse) # packages for maintaining consistent workflows
library(here) # manage file paths
library(janitor) # functions for cleaning data
library(readxl) # functions for reading Excel files
library(tsibble) # tools for working with time series data
library(lubridate) # functions to work with dates
library(feasts) # tools for working with time series data
library(patchwork) # tools for combining plots
library(purrr) # tools to run functions more efficiently
library(furrr) # functions for parallel processing
library(dplyr) # functions for data manipulation
library(broom) # tools to tidy model outputs into tidyverse format
library(nloptr) # package to generate randomized weights


## read in abundance data
coho <- readxl::read_xlsx(here('data', 'input', 'OC Coho Abundance.xlsx')) %>% # read xlsx file
  clean_names() %>% # clean column names; convert to lower case, replace spaces with underscores
  distinct() %>% # remove duplicate rows
  select(-tahkenitch) %>% # remove the 'tahkenitch' column due to computational errors when running nls
  select(-sixes) # remove the 'sixes' column due to computational errors when running nls 
