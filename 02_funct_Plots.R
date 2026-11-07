# 02_funct_Plots.R
# Plotting functions (use ggplot2, loaded in 00_requirements.R).

# plot_two_lines : two time series on the same plot
#   Input : year, series_a, series_b - numeric vectors of the same length
#           name_a, name_b - legend labels; ylab - y-axis label
#   Output: ggplot object
plot_two_lines <- function(year, series_a, series_b, name_a, name_b, ylab) {
  d <- data.frame(year = year, a = series_a, b = series_b)
  ggplot(d, aes(x = year)) +
    geom_line(aes(y = a, color = name_a)) +
    geom_line(aes(y = b, color = name_b)) +
    labs(x = "Year", y = ylab, color = "") +
    theme_minimal() +
    theme(legend.position = "bottom")
}

# plot_scatter : scatter plot with a straight regression line
#   Input : x, y - numeric vectors; xlab, ylab - axis labels
#   Output: ggplot object
plot_scatter <- function(x, y, xlab, ylab) {
  d <- data.frame(x = x, y = y)
  ggplot(d, aes(x = x, y = y)) +
    geom_point() +
    geom_smooth(method = "lm", formula = y ~ x) +
    labs(x = xlab, y = ylab) +
    theme_minimal()
}

# lag_correlations : correlation of x (k years earlier) with y, k = 0..max_lag
#   Input : x, y - numeric vectors in time order; max_lag - integer
#   Output: data frame with columns lag and correlation
lag_correlations <- function(x, y, max_lag = 5) {
  result <- data.frame(lag = 0:max_lag, correlation = NA)
  for (k in 0:max_lag) {
    x_shifted <- lag_by(x, k)
    result[["correlation"]][k + 1] <- cor(x_shifted, y, use = "complete.obs")
  }
  return(result)
}
