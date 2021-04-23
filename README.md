Import and visualize flow data from CHEQ 🌊
================================================================================


> A set of __functions__ to import, tidy and visualize flow data downloaded from CEHQ website. 


Data
--------------------------------------------------------------------------------


Data consist of two stations downloaded from the [CEHQ website](https://www.cehq.gouv.qc.ca/hydrometrie/historique_donnees/default.asp).

+ `062803_Q.txt` : Station on th Sainte-Margerite river.
+ `061004_Q.txt` : Station on the Chicoutimi river.


R script
--------------------------------------------------------------------------------


All steps are performed in `main.R`. Functions are stored in `R/functions/` :

+ `read_table.R` : Function to read the data table from the downloaded file from CEHQ website.
+ `read_info.R` : Function to read the station information from the downloaded file from CEHQ website.
+ `dates.R` : Helper functions for date in `date` and `integer` format.
+ `plot_helpers.R` : Helper functions to be used with the `ggplot2` package.
+ `plot_flow_series.R` : A general function to generate nice `ggplot2` plot of the flow series.
+ `plot_flow_pot.R` : A general function to generate nice `ggplot2` plot of the peaks over threshold.


Results
--------------------------------------------------------------------------------

### Full flow series of Sainte-Marguerite river

![](plots/smr_full_series.png)


### Subset of the flow series of Sainte-Marguerite river

![](plots/smr_sub_series.png)


### Full flow series of Chicoutimi river with `NA`s

![](plots/chi_full_series_na.png)


### Subset of the flow series of Chicoutimi river with `NA`s

![](plots/chi_full_series_na.png)


### Peaks-over-threshold for the full Chicoutimi river flow series

![](plots/chi_full_pot.png)


### Peaks-over-threshold for the last five years of the Sainte-Marguerite river

![](plots/chi_full_pot.png)


___Enjoy !___ ✌🏻
