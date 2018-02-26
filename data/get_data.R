# Load packages
library(magrittr)
library(rprojroot)
library(stringr)
library(data.table)

## Census Data

# Create functions which pre-append fully-expanded file paths to relative paths
root <- is_rstudio_project$make_fix_file()
data_dir <- function(...) root("data", ...)
#print(root(".")) # Try this

# Download the census data
outfile <- "census-income.data.gz"
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/census-income-mld/"
download.file(url = paste0(url, outfile), destfile = data_dir(outfile))

# Read the census data
census_income_data <- fread(paste("zcat <", shQuote(data_dir(outfile))))

# Get the attribute names
con <- url("https://archive.ics.uci.edu/ml/machine-learning-databases/census-income-mld/census-income.names")
html_names <- readLines(con)
close(con)
census_income_data_names <- html_names %>%
  # Select the rows with variable descriptions
  extract(143:184) %>%
  # Match everything before the ":" on each row
  str_match("^([^:]+):") %>% extract(, 2) %>%
  # Filter out the duplicate "instance weight" row
  extract(!str_detect(., "\\| instance weight")) %>%
  # Add a target variable name
  c("target")

names(census_income_data) <- census_income_data_names
saveRDS(census_income_data, file = data_dir("census_income_data.Rds"))

## HAR Data

outfile <- "dataset-har-PUC-Rio-ugulino.zip"
url <- "http://groupware.les.inf.puc-rio.br/static/har/"
download.file(url = paste0(url, outfile), destfile = data_dir(outfile))
csv_file <- unzip(data_dir(outfile), exdir = data_dir("."))

har_data <- fread(csv_file)
saveRDS(har_data, file = data_dir("har_data.Rds"))

## Adult Census Data

outfile <- "adult.data"
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/"
download.file(url = paste0(url, outfile), destfile = data_dir(outfile))
census_adult_data <- fread(data_dir(outfile))

# Get the attribute names
con <- url("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.names")
html_names <- readLines(con)
close(con)
names(census_adult_data) <- html_names %>%
  # Select the rows with variable descriptions
  extract(97:110) %>%
  # Match everything before the ":" on each row
  str_match("^([^:]+):") %>% extract(, 2) %>%
  # Add a target variable name
  c("target")

census_adult_data %>%
  as.data.frame() %>%
saveRDS(file = data_dir("census_adult_data.Rds"))
