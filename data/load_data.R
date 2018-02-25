library(rprojroot)
library(data.table)

# Create functions which pre-append fully-expanded file paths to relative paths
root <- is_rstudio_project$make_fix_file()
data_dir <- function(...) root("data", ...)
#print(root(".")) # Try this

har_data <- readRDS(data_dir("har_data.Rds"))
census_income_data <- readRDS(data_dir("census_income_data.Rds"))
