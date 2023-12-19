     

                               # Dynamic_SDM - hard substrate - summary #

# part1  - Preparing the occurrence data:
# - checking the formatting,completeness and validity of the records coordinates and dates (response)
# - excluding records outside a given spatial and temporal extent, typically dictated by the study's scope or the coverage of environmental datasets
# - filtering records by a specified spatial and temporal resolution

# General overview: 
# We need to make sure that our original data is ok. we can check different aspects and filter for them. 
# Then we need to upload the environmental data - chose the right variables and scale - check for collinearity in the variables (for raster predictors: 'sdm' -  sdmData\'ppredictors').
# Then we need to have train and test data - we can create it out of the main data set by sub-setting the data (there are automatic functions for that - 'sdm' -  sdmData\'train'
  ## or we can use an independent data set (another function in 'sdm' -  sdmData\'test').
# Then we need to chose the predictor and response variables to take in account - sometimes need to be specified for the model.'sdm' -  sdmData\'formula'
# Then we need to choose the algorithm - RF, BDT, regression
  
 ### 'sdm' functions by steps order:
#_1   # d = sdmData - a function that defines the input data - the syntax: response\sp1 (corals) ~  environmental predictor\env1 + env2 .. + coords (lon\x, lat\y) + time (date and time)
         # > d - shows the object 'd' summary
#_2   # m = sdm - a function that defines the model for species distribution. 'corals ~.' (variables), 'data = d', methods = c('glm', 'gbm', 'rf', 'maxent), {replication = 'sub', test.precent = 30, n=5}
       ## {} meaning - take a subset of the data by the rule of random 30% each time, for 5 times. Instead of subset we can also use other methods like bootstrapping and cross validation  
        # > m - shows the object m summary and the models we chose AUC (mean value)
#_3  # p1 = predict (m (model object - by the output of the sdm function), preds (predictors - raster), filename = 'test1.tif' (output if it is a raster))

# Important terms:  
# Positional uncertainty - the uncertainty in location due to random errors in measurement of any physical point on a survey based on the 95 percent confidence level.
# Spatial autocorrelation - a systematic pattern - positive or negative - in the spread of the data. 
# positive spatial autocorrelation - the tendency for areas or sites that are close together to have similar values.
# Multicollinearity - a statistical concept where several independent variables in a model are correlated. Two variables are considered perfectly collinear 
  ## if their correlation coefficient is +/- 1.0. Multicollinearity among independent variables will result in less reliable statistical inferences.

# Dealing with spatial autocorrelation: 
# package (usdm) -> website: http://r-gis.net - this package allows to check for spatial autocorrelation. -> it can also be used to correct for spatial uncertainty.
# paper: "spatial auto correlation in predictors reduces the impact of positional uncertainty...."'"

# substrates:
# 1 - sand
# 2 - 
# 3 - corals
# 4 - 

# - - - - - - - - - 

# -> packages

library(dynamicSDM) # -  sdm and spatial auto correlation - from Yoni
library(sdm)        # -  sdm and spatial auto correlation - from a YouTube video
library(dplyr)      # -  data manipulation and organization
library(tidyr)      # -  data manipulation and organization
library(here)       # -  working directory leads to the R project location
library(mapview)    # -  interactive viewing of spatial data
library(raster)     # -  uploading tif\raster files + creating a buffer zone to define the study area
library(rworldmap)  # -  world map 
library(ggplot2)    # -  for ploting and visualization
library(sf)   



 











