select_country_years <- function(raw_df) {
  # Select country name, code, and columns from 1970 to 2025
  clean_df <- raw_df %>%
    select(Country = REF_AREA_LABEL, Code = REF_AREA, `1970`:`2025`)
  
  return(clean_df)
}


make_data_long <- function(wide_df) {
  long_df <- wide_df %>%
    pivot_longer(
      cols = `1970`:`2025`,
      names_to = "Year",
      values_to = "Edu_Expenditure_Pct_GDP"
    ) %>%
    mutate(
      Year = as.integer(Year),
      Edu_Expenditure_Pct_GDP = as.numeric(Edu_Expenditure_Pct_GDP)
    ) %>%
    filter(!is.na(Edu_Expenditure_Pct_GDP))
  
  return(long_df)
}
