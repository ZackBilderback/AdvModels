library(datasets)

# Define UI for application that draws a histogram
ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Telephones by region"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      checkboxGroupInput("variable", "Filter by Variable", c('Region','Year'), selected = 'Region'),
      selectInput("region", "Region:",
                  choices=colnames(WorldPhones)),
      selectInput("year", "Year:", 
                  choices=rownames(WorldPhones)),
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot")  
    )
    
  )
)

server <- shinyServer(function(input, output) {
  
  output$phonePlot <- renderPlot({
    
    if (input$variable == 'Region') {
      # Render a barplot
      barplot(WorldPhones[,input$region]*1000, 
              main=input$region,
              ylab="Number of Telephones",
              xlab="Year")
    }
    else {
      barplot(WorldPhones[input$year,]*1000, 
              main=input$year,
              ylab="Number of Telephones",
              xlab="Region")
    }
    
  })
})

shinyApp(ui = ui, server = server)