# s1_data_download.R


# Fetch stations and download data for a given region.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : Jeremie.Boudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...



# Librairies -------------------------------------------------------------------


library(data.table)
library(ggplot2)
library(rvest)
library(dplyr)


# Functions --------------------------------------------------------------------


source(file.path("R", "functions", "dates.R"))
source(file.path("R", "functions", "download_stns_files.R"))
source(file.path("R", "functions", "fetch_stns.R"))


# Fetch stations ---------------------------------------------------------------


# Fetch station number from the sixth hydrological region (SLSJ).
stns <- fetch_stns(6L)

# Results.
stns


# Download stations files ------------------------------------------------------


# Download all stations with flow information (Q).
download_stns_files(
    station_numbers = stns$No_de_la_station,
    suffix          = "Q",
    replace         = TRUE,
    wait            = 1L,
    verbose         = FALSE,
    path            = "data"
)

# Note : Files are now downloaded into the data/ folder.

