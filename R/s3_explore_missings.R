# s3_explore_missings.R


# Exploration of missing values in all stations with nice built-in functions.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : Jeremie.Boudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...



# Librairies -------------------------------------------------------------------


library(data.table)
library(ggplot2)


# Functions --------------------------------------------------------------------


source(file.path("R", "functions", "dates.R"))
source(file.path("R", "functions", "plot_helpers.R"))
source(file.path("R", "functions", "read_table.R"))
source(file.path("R", "functions", "read_info.R"))


# Imports ----------------------------------------------------------------------


# List available files.
files <- list.files(file.path("data"))

# Load all files.
stns <- lapply(file.path("data", files), read_table)

# Load all infos.
infos <- lapply(file.path("data", files), read_info)

# Add names.
names(stns) <- substr(files, 1L, nchar(files) - 6L)
names(infos) <- substr(files, 1L, nchar(files) - 6L)


# Calculate NA statistics ------------------------------------------------------


# Calculate longest run of NA for a given vector "x".
calc_longest_na_run <- function(x) {

    # Extract runs of NAs.
    runs <- rle(is.na(x))

    # Check if there are any NAs.
    if (all(runs$values == FALSE)) {
        return(0L)

    # If so, return the longest runs.
    } else {
        return(max(runs$length[runs$values == TRUE]))
    }
}

# Function to calculate NA statistics.
calc_na_stats <- function(stn, window = "year") {

    # Create a very generic table of NAs.
    na_tbl <- stn[, .(
        N_NA_OBS   = sum(is.na(FLOW)),
        N_OBS      = .N,
        N_TOT      = 365L + is_leap(YEAR),
        NA_RUN_MAX = calc_longest_na_run(FLOW)
    ), by = YEAR]

    # Calculate true number of NAs.
    na_tbl[, N_NA_TOT := N_NA_OBS + (N_TOT - N_OBS)]

    # Calculate percentage of NAs.
    na_tbl[, P_NA_TOT := N_NA_TOT / N_TOT]

    # Return the table.
    return(na_tbl[])

}


# Plot NA statistics -----------------------------------------------------------


plot_na_map <- function(stns,
    windows    = "year",
    from       = 1970L,
    to         = 2020L,
    max_p_na   = 0.05,
    max_n_na   = 5L,
    max_na_run = 3L
) {

    # Extract names of stations.
    stns_names <- names(stns)

    # First, run calc_na_stats on all stations with an extra column for STN_ID.
    res <- lapply(stns, calc_na_stats, window = window)

    # Reorder into a data.table.
    na_tbl <- do.call("rbind", res)

    # Add stations number.
    na_tbl[, STN_ID := rep(stns_names, times = unlist(lapply(res, nrow)))]

    # Subset the table with "from" and "to".
    na_tbl <- na_tbl[YEAR >= from & YEAR <= to, ]

    # Add color of the points.
    na_tbl[, MISS := "Yes"]
    na_tbl[P_NA_TOT   < max_p_na &
           N_NA_TOT   < max_n_na &
           NA_RUN_MAX < max_na_run,
           MISS := "No"]

    # Generate a nice order to plot the stations.
    summ <- na_tbl[, .(N = sum(MISS == "No")), by = STN_ID]

    # Extract order of the table.
    order_stn <- summ[order(N, decreasing = TRUE), STN_ID]

    # Convert to factor prior to plot.
    na_tbl[, STN_ID := factor(STN_ID, levels = rev(order_stn))]

    # Plot the graph nicely.
    ggplot(
        data    = na_tbl,
        mapping = aes(
            x   = YEAR,
            y   = STN_ID
        )
    ) +
    geom_point(
        mapping = aes(
            col = MISS
        ),
        cex     = 1.5,
        pch     = 19L
    ) +
    geom_text(
        data    = summ,
        mapping = aes(
            y     = STN_ID,
            x     = Inf,
            label = N
        ),
        hjust = 1.2,
        cex   = 3L
    ) +
    labs(
        title = "Overview of missing values",
        x     = "Year",
        y     = "Stations",
        col   = "Too many missing :"
    ) +
    scale_color_manual(
        values = c("#4575b4", "#d73027")
    ) +
    custom_theme()

}


plot_na_map(stns, from = 1970, to = 2020, "year", 0.05, Inf, 3L)
