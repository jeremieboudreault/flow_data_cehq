# plot_flow_series.R


# Plot flow series nicely using ggplot2.


plot_flow_series <- function(
    x       = x,
    info    = info,
    spot.na = FALSE,
    start   = "1800/01/01",
    end     = "2100/01/01"
) {

    # Convert 'start' and 'end' to integer format.
    starti <- date_to_int(start)
    endi   <- date_to_int(end)

    # First, subset "x" to corresponding time windows.
    x <- x[DATEI >= starti & DATEI <= endi, ]

    # Calculate range of date in years.
    range_year <- (endi - starti) / 10000

    # Calculate line width.
    line_wth <- if (range_year < 2) {
        0.7
    } else if (range_year >= 2 & range_year < 10) {
        0.5
    } else if (range_year >= 10 & range_year < 50) {
        0.3
    } else {
        0.1
    }

    # Create the base plot.
    p <- ggplot(
        data    = x,
        mapping = aes(
            x = DATE,
            y = FLOW
        )
    )

    # Spot NAs.
    if (spot.na & sum(is.na(x$FLOW)) > 0) {
        p <- p +
        geom_line(
            data  = x[FLAG != "NA", ],
            color = "#E41A1C",
            cex   = max(line_wth - 0.1, 0.01)
        ) +
        geom_point(
            data = x[FLAG == "NA", ],
            mapping = aes(
                x = DATE,
                y = 0L
            ),
            pch = 4L,
            col = "#E41A1C",
            cex = line_wth
        )
    }

    # Complete the plot
    p <- p +
    geom_line(
        cex   = line_wth,
        na.rm = TRUE
    ) +
    labs(
        title    = info$DESC,
        subtitle = paste0("(Station ", info$STATION_ID, ")"),
        x     = "Date",
        y     = "Flow (m³/s)"
    ) +
    custom_theme()

    # Return p.
    return(p)

}



