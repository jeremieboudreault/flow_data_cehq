# s2_import_and_plot_data.R


# Import data from some stations and do some basic plots.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : Jeremie.Boudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...



# Path to some specific stations -----------------------------------------------


# Sainte-Marguerite river <SMR>.
path_smr <- file.path("data", "062803_Q.txt")

# Chicoutimi river <CHI>.
path_chi <- file.path("data", "061004_Q.txt")


# Read information about the station -------------------------------------------


# Read SRM info.
smr_info <- read_info(path_smr)
smr_info

# Read CHI info.
chi_info <- read_info(path_chi)
chi_info


# Read station data ------------------------------------------------------------


# Read SRM table.
smr_tbl <- read_table(path_smr)
smr_tbl

# Read CHI table.
chi_tbl <- read_table(path_chi)
chi_tbl


# Data exploration -------------------------------------------------------------


# Number of years of obersations.
nrow(smr_tbl)/365.25      # ~ 22 years
nrow(chi_tbl)/365.25      # ~ 111 years

# Number of missing.
sum(is.na(smr_tbl$FLOW))  # 0
sum(is.na(chi_tbl$FLOW))  # 906


# Plot flow series -------------------------------------------------------------


# Full series of the Sainte-Marguerite river.
plot_flow_series(
    x       = smr_tbl,
    info    = smr_info,
)

# Subset of the Sainte-Marguerite river series.
plot_flow_series(
    x       = smr_tbl,
    info    = smr_info,
    start   = "2019/01/01",
    end     = "2020/12/31"
)

# Full series of Chicoutimi river with spotted NAs.
plot_flow_series(
    x       = chi_tbl,
    info    = chi_info,
    spot.na = TRUE,
)

# Subset of the Chicoutimi river series with spotted NAs.
plot_flow_series(
    x       = chi_tbl,
    info    = chi_info,
    spot.na = TRUE,
    start   = "1918/03/01",
    end     = "1919/11/01"
)


# Peaks over threshold ---------------------------------------------------------


# All peak over threshold for Chicoutimi.
plot_flow_pot(
    x      = chi_tbl,
    info   = chi_info,
    thresh = 300L
)

# Peaks over threshold for the last 5 years of Sainte-Marguerite River.
plot_flow_pot(
    x      = smr_tbl,
    info   = smr_info,
    thresh = quantile(smr_tbl$FLOW, 0.995, na.rm = TRUE),
    start  = "2016/01/01",
    end    = "2020/12/31"
)
