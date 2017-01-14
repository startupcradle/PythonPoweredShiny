# Title: Example of Calling a RESTful API from an RShiny APP
# Description:
#   This is the user-interface definition of a Shiny web application.
#   You can find out more about building applications with Shiny here:
#   http://shiny.rstudio.com
#
# Author: Dan Dixey (QbizUK)
# Created: 14/1/2017
# Updated: 14/1/2017
#

# Shiny UI ----------------------------------------------------------------
shinyUI(fluidPage(

  # Application title -----------------------------------------------------  
  titlePanel("Example of Using a RESTful API from RShiny"),

  # Sidebar with a slider input for number of bins ------------------------  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", 
                  "Dataset", 
                  c("rock", "pressure", "cars")),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution and Table -----------------    
    mainPanel(
      plotOutput("distPlot"),
      DT::dataTableOutput("table")
      )
    )
  )
)



