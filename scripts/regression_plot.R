scale_pld_x <- list(
  ggplot2::scale_x_continuous(
    "% PLD of Amiodarone",
    breaks = log(c(.15, .25, .50, 1)),
    labels = c("15", "25", "50", "100"),
    expand = c(.01,.01)))

scale_infection_y <- list(
  ggplot2::scale_y_continuous(
    "% SARS-CoV-2 (Normalized to DMSO)",
    breaks = sqrt(c(0, 10, 50, 100, 150)),
    labels = c("0", "10", "50", "100", "150"),
    expand = c(0, .01)))

scale_infection_x <- list(
  ggplot2::scale_x_continuous(
    "% SARS-CoV-2 (Normalized to DMSO)",
    breaks = sqrt(c(0, 10, 50, 100, 150)),
    labels = c("0", "10", "50", "100", "150"),
    expand = c(0, .01)))

regression_plot <- function(model){
  samples <- data %>%
    tidybayes::add_fitted_draws(model, n=100)
  
  ggplot2::ggplot(data = data) + 
    ggplot2::theme_bw() +
    ggplot2::theme(legend.key.height=unit(.9, "line")) +
    ggplot2::coord_cartesian(
      xlim = log(c(min(data$pld_mean), 1.5)),
      ylim = sqrt(c(0, c(max(data$infection_mean) + 8)))) +
    ggplot2::geom_line(
      data = samples,
      mapping = ggplot2::aes(
        x = log(pld_mean),
        y = .value,
        group = .draw),
      alpha = .05,
      color = "blue") +
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        x = log(pld_mean),
        y = sqrt(infection_mean),
        shape = drug)) +
    ggplot2::geom_point(
      data = prospective_data,
      mapping = ggplot2::aes(
        x = log(pld_mean),
        y = sqrt(infection_mean),
        color = "red",
        shape = drug)) +
    ggplot2::ggtitle(
      label = paste0("Infection by PLD: ", model$name, " model")) +
    scale_pld_x +
    scale_infection_y +
    ggplot2::scale_shape_manual(
      "Drug",
      values = 1:(length(unique(data$drug)) + length(unique(prospective_data$drug)))) +
    MPStats::loo_R2_indicator(
      model,
      group = 1,
      xpos = "right",
      ypos = "top")
}
