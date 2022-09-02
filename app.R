# Github Link: https://github.com/pkinif/shiny_select_input_benchmarck

# My Conclusion
# -------------
# 
# Option 1 allows to display more than 1000 values (here 3000) but the input is slow even with the server feature
# Option 2 doesn't allow to display more than 1000 values
# Option 3 allows to display more than 1000 values (here 3000) but the design to select more than one value is not efficient
# --> you need to use the CTRL button
# Option 4 allows to display more than 1000 values (here 3000) and the UI is really nice/efficient --> this is my best one



library(shiny)
library(shinyWidgets)

ui <- fluidPage(
  wellPanel(
    fluidRow(
      column(12, offset = 0,
             titlePanel("Select Input App"))),
    fluidRow(
      column(
        width = 3, 
        offset = 0,
        selectizeInput(
          inputId = "selectizeInput", 
          label = "1/ selectizeInput", 
          choices = NULL,
          multiple = T,
          options = list(
            placeholder = "Type airport code",
            maxOptions = 3000
          )
        )
      ),
      column(
        width = 3,
        selectInput(
          inputId = "selectInput", 
          label = "2/ selectInput with selectsize = T", 
          multiple = T,
          choices = 1:3000,
          selectize = T
        )
      ),
      column(
        width = 3,
        selectInput(
          inputId = "selectInput2", 
          label = "3/ selectInput with selectsize = F", 
          multiple = T,
          choices = 1:3000,
          selectize = F
        )
      ),
      column(
        width = 3,
        shinyWidgets::pickerInput(
          inputId = "pickerInput",
          label = "4/ shinywidget::pickerInput", 
          choices = 1:3000,
          options = list(
            `actions-box` = TRUE), 
          multiple = TRUE
        )
      )
    ),
    
    fluidRow(
      column(
        width = 3,
        verbatimTextOutput("result1")
      ),
      column(
        width = 3,
        verbatimTextOutput("result2")
      ),
      column(
        width = 3,
        verbatimTextOutput("result3")
      ),
      column(
        width = 3,
        verbatimTextOutput("result4")
      )
    )
  )
)

server <- function(input, output, session) {
  
  updateSelectizeInput(session, "selectizeInput",
                       choices = 1:3000, server = TRUE)
  
  output$result1 <- renderPrint({
    print(input$selectizeInput)
  })
  
  output$result2 <- renderPrint({
    print(input$selectInput)
  })
  
  output$result3 <- renderPrint({
    print(input$selectInput2)
  })
  
  output$result4 <- renderPrint({
    print(input$pickerInput)
  })
  
  
}

shinyApp(ui = ui, server = server)