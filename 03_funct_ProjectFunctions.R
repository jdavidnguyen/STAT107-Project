# 03_funct_ProjectFunctions.R
# Functions for reading the NCES and FRED data, computing growth and lags, and
# keeping the US rows of the World Bank data.
# (The World Bank functions select_country_years() and make_data_long() are in
#  01_funct_DataCleaning.R. filter_us_wb() below is used after them.)

# ---------------------------------------------------------------------------
# read_nces_table106 : read NCES Table 106.10 (saved as a .csv)
#   Input : path - path to tabn106_10.csv
#   Output: data frame with one row per year and the columns
#           year, gdp_nominal_bn, school_year, edu_total_mn, edu_k12_mn,
#           edu_postsec_mn  (spending in millions of current dollars)
#   Notes : The first 5 rows of the file are headers and the last rows are
#           footnotes, so we skip the headers and drop rows without a year.
# ---------------------------------------------------------------------------
read_nces_table106 <- function(path) {
  raw <- read.csv(path, skip = 5, header = FALSE, stringsAsFactors = FALSE)
  nces <- raw[, c(1, 2, 3, 5, 7, 10)]
  names(nces) <- c("year", "gdp_nominal_bn", "school_year",
                   "edu_total_mn", "edu_k12_mn", "edu_postsec_mn")
  # "---" means not available; as.numeric turns it into NA
  nces[["year"]]           <- suppressWarnings(as.numeric(nces[["year"]]))
  nces[["gdp_nominal_bn"]] <- suppressWarnings(as.numeric(nces[["gdp_nominal_bn"]]))
  nces[["edu_total_mn"]]   <- suppressWarnings(as.numeric(nces[["edu_total_mn"]]))
  nces[["edu_k12_mn"]]     <- suppressWarnings(as.numeric(nces[["edu_k12_mn"]]))
  nces[["edu_postsec_mn"]] <- suppressWarnings(as.numeric(nces[["edu_postsec_mn"]]))
  nces <- nces[!is.na(nces[["year"]]), ]   # removes the footnote rows
  return(nces)
}

# ---------------------------------------------------------------------------
# read_fred_annual : read FRED GDPC1 (quarterly) and average it by year
#   Input : path - path to GDPC1.csv (columns observation_date, GDPC1)
#   Output: data frame with year and real_gdp_bn (billions of 2017 dollars)
# ---------------------------------------------------------------------------
read_fred_annual <- function(path) {
  gdp_q <- read.csv(path)
  gdp_q[["year"]] <- as.numeric(substr(gdp_q[["observation_date"]], 1, 4))
  gdp_annual <- aggregate(GDPC1 ~ year, data = gdp_q, FUN = mean)
  names(gdp_annual) <- c("year", "real_gdp_bn")
  return(gdp_annual)
}

# ---------------------------------------------------------------------------
# pct_growth : year-over-year percent change
#   Input : x - numeric vector in time order
#   Output: numeric vector of the same length (first value is NA)
# ---------------------------------------------------------------------------
pct_growth <- function(x) {
  n <- length(x)
  c(NA, 100 * (x[2:n] - x[1:(n - 1)]) / x[1:(n - 1)])
}

# ---------------------------------------------------------------------------
# lag_by : shift a vector k positions back in time
#   Input : x - numeric vector in time order; k - number of years
#   Output: numeric vector of the same length (first k values are NA)
# ---------------------------------------------------------------------------
lag_by <- function(x, k) {
  c(rep(NA, k), x[1:(length(x) - k)])
}

# ---------------------------------------------------------------------------
# filter_us_wb : keep only the United States
#   Input : long_df - output of make_data_long()
#   Output: data frame with year and wb_gov_edu_pct_gdp
filter_us_wb <- function(long_df) {
  us <- filter(long_df, Code == "USA")
  data.frame(year = us[["Year"]], wb_gov_edu_pct_gdp = us[["Edu_Expenditure_Pct_GDP"]])
}
