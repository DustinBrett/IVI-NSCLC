# This script runs all files in the data-raw directory and creates all required
# datasets in the data directory. It should be run from inside the data-raw
# directory.

rm(list = ls())
unlink("../data/*") # deletes all files in data directory
source("treatments.R")
source("age.R")
source("params_mstate_nma.R")
source("adverse_events.R")
source("params_ae_nma.R")
source("params_utility.R")
source("params_costs_tx.R")
source("params_costs_op.R")
source("params_costs_inpt.R")
source("params_costs_ae.R")
source("params_costs_prod.R")