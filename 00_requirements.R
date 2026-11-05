# STAT 107 - Requirements Script
# File: 00_requirements.R
# This script installs and loads all required packages for our project.

# Check and install packages if they aren't already installed
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("readr")) install.packages("readr")
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("knitr")) install.packages("knitr")
if (!require("rmarkdown")) install.packages("rmarkdown")

# Load all libraries needed for the project
library(tidyverse)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(knitr)
library(rmarkdown)

print("All required packages are loaded!")
