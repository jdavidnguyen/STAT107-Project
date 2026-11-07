# STAT107-Project
00_requirements.R: Setup script that installs and loads all R packages required for the project.
01_funct_DataCleaning.R: Contains custom R functions used to filter missing observations, handle outliers, and format variable types.
02_funct_Plots.R: Custom visual wrapper functions built on `ggplot2` to ensure consistent plotting aesthetics across files.
11_DataCleaning.Rmd: Takes raw data from `data/raw_data.csv`, performs missing-value filtering and type conversion, and outputs the cleaned workspace to `13_DataSaving.RData`.
21_DataProcessing.Rmd: Loads `13_DataSaving.RData`, executes feature transformations (e.g., log transformations, categorical binning), and saves the resulting workspace to `22_DataSaving.RData`.
31_DataVisualization.Rmd: Loads `22_DataSaving.RData` and generates preliminary distribution plots, box plots, and numerical summary tables.
WB_WDI_SE_XPD_TOTL_GD_ZS_WIDEF.csv: Raw World Bank dataset containing total government expenditure on education (% of GDP) from 1970 to 2025 across 250 countries/entities.
