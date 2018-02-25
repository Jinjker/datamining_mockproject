# Data

## Description

1. Cylinder band prediction in rotogravure printing:
http://archive.ics.uci.edu/ml/datasets/Cylinder+Bands
2. US census dataset:
https://archive.ics.uci.edu/ml/datasets/Adult
A larger, [more challenging version](https://archive.ics.uci.edu/ml/machine-learning-databases/census-income-mld/census-income.data.html) is also available:
https://archive.ics.uci.edu/ml/datasets/Census-Income+%28KDD%29
(You can use either of the two versions.)
3. Human activity recognition based on accelerometer data:
http://groupware.les.inf.puc-rio.br/har

## Source Files

- `get_data.R`
    1. Download the project datasets from their respective HTML sites
    2. Add any missing column names
    3. Save them to `.rds` objects in `data/`
- `load_data.R`
    1. Load the `.rds` R objects without needing to re-download source ZIP files
