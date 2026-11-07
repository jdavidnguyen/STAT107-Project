plot_education_trend <- function(df, country_list) {
  
  df_filtered <- df %>%
    filter(Country %in% country_list)
  
  p <- ggplot(df_filtered, aes(x = Year, y = Edu_Expenditure_Pct_GDP, color = Country)) +
    geom_line() +
    geom_point() +
    labs(
      title = "Government Expenditure on Education (% of GDP)",
      x = "Year",
      y = "Expenditure (% of GDP)",
      color = "Country"
    ) +
    theme_minimal()
  
  return(p)
}
