# plot_flow_pot.R


# Plot peaks over threshold for the flow series using ggplot2.



plot_flow_pot <- function(
    x,
    info,
    thresh  = NULL,
    start   = "1800/01/01",
    end     = "2100/01/01"
) {

    # Calculate threshold if empty using the full series.
    if (is.null(thresh)) {
        thresh <- quantile(x$FLOW, 0.95, na.rm = TRUE)
    }

    # Convert 'start' and 'end' to integer format.
    starti <- date_to_int(start)
    endi   <- date_to_int(end)

    # First, subset "x" to corresponding time windows.
    x <- data.table::copy(x[DATEI >= starti & DATEI <= endi, ])

    # Calculate range of date in years.
    range_year <- (endi - starti) / 10000

    # Calculate line width.
    pch_cex <- if (range_year < 2) {
        c(0.85, 0.9)
    } else if (range_year >= 2 & range_year < 10) {
        c(0.7, 0.8)
    } else if (range_year >= 10 & range_year < 50) {
        c(0.3, 0.4)
    } else {
        c(0.1, 0.3)
    }

    # Create a POT indicator.
    x[, POT := FALSE]
    x[FLOW > thresh, POT := TRUE]

    # Create the base plot.
    p <- ggplot(
        data    = x,
        mapping = aes(
            x = DATE,
            y = FLOW
        )
    ) +
    geom_point(
        mapping = aes(
            col = POT,
            cex = POT,
        ),
        na.rm       = TRUE,
        show.legend = FALSE
    ) +
    scale_size_manual(
        values = pch_cex
    ) +
    labs(
        title    = info$DESC,
        subtitle = paste0("(Station ", info$STATION_ID, ")"),
        x        = "Date",
        y        = "Flow (m³/s)"
    ) +
    geom_hline(
        yintercept = thresh,
        alpha      = 0.5,
        lty        = 2L
    ) +
    scale_color_manual(
        values = c("#377EB8", "#E41A1C")
    ) +
    custom_theme()

    # Return p.
    return(p)

}

