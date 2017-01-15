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
if (!is.installed("shinydashboard")) {
  install.packages("shinydashboard")
}

# Load dependencies -------------------------------------------------------
library(shiny)
library(DT)
library(jsonlite)
library(shinydashboard)

# Pull from URL -----------------------------------------------------------
get_API <- function(url) {
  df <- fromJSON(url)
  json_data_frame <- fromJSON(df$payload)
  json_data_frame
}


# Simple Authentication ---------------------------------------------------
# Ideally this needs to be in a secure location...
credentials = list("uadmin" = "padmin",
                   "uuser" = "puser")

login <- box(title = "Login Page",
             textInput("userName",
                       "Username"),
             passwordInput("passwd", 
                           "Password"),
             br(),
             actionButton("Login", 
                          "Log in"))

loginfail <- box(title = "Login Page",
                 textInput("userName", 
                           "Username"),
                 passwordInput("passwd", 
                               "Password"),
                 p("Username or password incorrect"),
                 br(),
                 actionButton("Login", label = "Log in"))

# 0: not attempted, -1: failed, 1: passed
Logged = FALSE
LoginPass = 0
