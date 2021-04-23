# main.R


# Import data and extract relevant information from CEHQ.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : Jeremie.Boudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...



# Librairies -------------------------------------------------------------------


library(data.table)


# Functions --------------------------------------------------------------------


source(file.path("R", "functions", "date_to_int.R"))
source(file.path("R", "functions", "read_table.R"))
source(file.path("R", "functions", "read_info.R"))


# Path to file -----------------------------------------------------------------


path <- file.path("data", "062803_Q.txt")


# Read information about the station -------------------------------------------


stn_info <- read_info(path)
stn_info


# Read table -------------------------------------------------------------------


stn_x <- read_table(path)
stn_x

