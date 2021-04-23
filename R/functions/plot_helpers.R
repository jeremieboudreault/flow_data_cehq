# plot_helpers.R


# Helpers function for the plots.



# Custom theme -----------------------------------------------------------------


custom_theme <- function(x) {
    theme_bw() +
    theme(
        panel.border = element_blank(),
        axis.line    = element_line(
            colour = "grey50"
        ),
        plot.title   = element_text(
            face  = "bold",
            hjust = 0.5,
            size  = 12L
        ),
        plot.subtitle = element_text(
            hjust = 0.5,
            size  = 11L
        )
    )
}

