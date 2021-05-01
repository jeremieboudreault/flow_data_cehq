# plot_helpers.R


# Helpers function for the plots.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : jeremieboudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...


# custom_theme() : A customised theme for ggplot2.
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
        ),
        legend.position = "bottom"
    )
}

