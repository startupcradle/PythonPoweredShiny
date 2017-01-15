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
shinyServer(function(input, output, session) {
  
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
  
  # Authentication --------------------------------------------------------
  USER <- reactiveValues(Logged = Logged, LoginPass = LoginPass)
  observe({
    if (USER$Logged == FALSE) {
      
      if (!is.null(input$Login)) {
        
        if (input$Login > 0) {
          
          username <- isolate(input$userName)
          password <- isolate(input$passwd)
          
          if (password == credentials[[username]]) {
            USER$Logged <<- TRUE
            USER$LoginPass <<- 1
          }
          USER$LoginPass <<- -1
        }
      }
    }
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
  
  output$value <- renderPrint({ 
    if (input$text == "") {
      output = ""
    } else {
      name = input$text 
      body <- list(data = list(Name = name))
      r <- POST(url = "http://localhost:8000/data", body = body, 
                encode = "json", verbose())
      output <- content(r, "parsed")$Message
    }
    output
  })
  
  # UI Output -------------------------------------------------------------
  output$ui <- renderUI({
    if (USER$Logged == TRUE) {
      mainbody
    }
    else {
      if (USER$LoginPass >= 0) {
        login
      }
      else {
        loginfail
      }
    }
  })
  
  # Output UI -----------------------------------------------------------------
  mainbody <- fluidPage(
      
      # Application title -----------------------------------------------------  
      titlePanel("Example of Using a RESTful API from RShiny"),
      
      # Sidebar with a slider input for number of bins 
      sidebarLayout(
        sidebarPanel(
          selectInput("dataset", 
                      "Dataset", 
                      c("rock", "pressure", "cars")),
          sliderInput("bins",
                      "Number of bins:",
                      min = 1,
                      max = 50,
                      value = 30),
          textInput("text", 
                    label = h3("Text input"), 
                    value = ""),
          verbatimTextOutput("value")
        ),
        
        
        # Show a plot of the generated distribution and Table   
        mainPanel(
          plotOutput("distPlot"),
          DT::dataTableOutput("table")
        )
      )
    )
  
})
