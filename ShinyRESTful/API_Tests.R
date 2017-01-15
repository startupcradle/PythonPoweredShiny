# Title: Example of Calling a RESTful API
# Description:
#   Example Queries
#
# Author: Dan Dixey (QbizUK)
# Created: 14/1/2017
# Updated: 14/1/2017
#

# Function to check if packages are installed ---------------------
library(httr)
library(jsonlite)

# Check the API is Running ----------------------------------------
r <- GET("http://localhost:8000")
str(content(r))

# Pull from URL (GET) ---------------------------------------------
get_API <- function(url) {
  df <- fromJSON(url)
  json_data_frame <- fromJSON(df$payload)
  json_data_frame
}
rock = get_API("http://localhost:8000/rock")
pressure = get_API("http://localhost:8000/pressure")
cars = get_API("http://localhost:8000/cars")

# Send data (PUT) ------------------------------------------------
name = "Dan!"
body <- list(data = list(Name = name))
r <- POST(url = "http://localhost:8000/data", body = body, 
          encode = "json", verbose())
output <- content(r, "parsed")$Name
output
