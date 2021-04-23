# main.R


# Import data and extract relevant information from CEHQ.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : Jeremie.Boudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...



# Librairies -------------------------------------------------------------------


library(data.table)
library(ggplot2)


# Functions --------------------------------------------------------------------


source(file.path("R", "functions", "date_to_int.R"))
source(file.path("R", "functions", "read_table.R"))
source(file.path("R", "functions", "read_info.R"))
source(file.path("R", "functions", "plot_flow_series.R"))
source(file.path("R", "functions", "plot_flow_bmax.R"))
source(file.path("R", "functions", "plot_flow_pot.R"))


# Path to file -----------------------------------------------------------------


path <- file.path("data", "062803_Q.txt")


# Read information about the station -------------------------------------------


stn_info <- read_info(path)
stn_info



# Read table -------------------------------------------------------------------


x <- read_table(path)
x


# Plot flow series -------------------------------------------------------------


# Full series.
plot_flow_series(
    x       = x,
    info    = stn_info,
)

# Full series with spotted NAs.
plot_flow_series(
    x       = x,
    info    = stn_info,
    spot.na = TRUE,
)

# Subset of the series.
plot_flow_series(
    x       = x,
    info    = stn_info,
    start   = 20200101,
    end     = 20201231
)

# Subset of the series with spotted NAs.
plot_flow_series(
    x       = x,
    info    = stn_info,
    spot.na = TRUE,
    start   = 20200101,
    end     = 20201231
)


# Block maxima -----------------------------------------------------------------


plot_flow_bmax(
    x      = x,
    info   = stn_info,
    block  = "year"
)


# POT --------------------------------------------------------------------------


plot_flow_pot(
    x      = x,
    info   = stn_info,
    thres  =  quantile(x$FLOW, 0.95)
)



