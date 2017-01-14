# Title: Example of Calling a RESTful API from an RShiny APP
# Description:
#   This is the server logic for a Shiny web application.
#   You can find out more about building applications with Shiny here:
#   http://shiny.rstudio.com
#
# Author: Dan Dixey (QbizUK)
# Created: 14/1/2017
# Updated: 14/1/2017
#

# Server.R  ---------------------------------------------------------------
shinyServer(function(input, output) {
  
  # Storing data Server Side ----------------------------------------------
  # The API provide three endpoints:
  #   1. cars => [http://localhost:8000/cars](http://localhost:8000/cars)
  #   2. pressure => [http://localhost:8000/pressure](http://localhost:8000/pressure)
  #   3. rock => [http://localhost:8000/rock](http://localhost:8000/rock)
  datasetInput <- reactive({
    switch(
      input$dataset,
      "rock" = get_API("http://localhost:8000/rock"), 
      "pressure" = get_API("http://localhost:8000/pressure"),
      "cars" = get_API("http://localhost:8000/cars")
    )
  })
  
  # Simple Histogram ------------------------------------------------------
  output$distPlot <- renderPlot({
    
    # Prepare for the plot
    data = datasetInput()
    x    <- data[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, 
         xlab = colnames(data)[2],
         ylab = "Frequency",
         breaks = bins,
         col = 'darkgray',
         border = 'white')
  })
  
  # DataTable View --------------------------------------------------------
  output$table <- DT::renderDataTable(DT::datatable({
    data <- datasetInput()
    data
  }))
  
})
