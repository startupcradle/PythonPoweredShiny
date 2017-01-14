# Title: Example of Calling a RESTful API from an RShiny APP
# Description:
#  a supporting file that creates variables and functions that are
#  globally available to bother the server and UI scripts
# Author: Dan Dixey (QbizUK)
# Created: 14/1/2017
# Updated: 14/1/2017
#

# Function to check if packages are installed ---------------------
is.installed <- function(mypkg) {
  is.element(mypkg, installed.packages()[, 1])
}

if (!is.installed("shiny")) {
  install.packages("shiny")
}
if (!is.installed("DT")) {
  install.packages("DT")
}
if (!is.installed("jsonlite")) {
  install.packages("jsonlite")
}

# Load dependencies -------------------------------------------------------
library(shiny)
library(DT)
library(jsonlite)

# Pull from URL -----------------------------------------------------------
get_API <- function(url) {
  df <- fromJSON(url)
  json_data_frame <- fromJSON(df$payload)
  json_data_frame
}
