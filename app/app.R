#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(RColorBrewer)
library(shinythemes)
library(shinyWidgets)
source("data.R")


#ui 

ui <- fluidPage(    
  
  #Selecting "spacelab theme"
  theme = shinytheme("united"),
  
  # Give the page a title
  titlePanel("Beer Reviews"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      # A search bar widget that inputs beer name
      
      pickerInput("beer_name", "Enter Beer Name:", 
                  choices=unique(beer_long$beer_name),
                  options = list(
                    `live-search` = TRUE 
                  )),
      
      hr(),
      textOutput("b_style")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("beerPlot")  
    )
    
  )
)  

#server 

server <- function(input, output) {
  
  
  # Fill in the spot we created for a plot


  
  output$beerPlot <- renderPlot({
    
    b_name <- input$beer_name
    
    bar <- beer_long[beer_long$beer_name == b_name,
                     c("review", "value")]
    
    coul <- brewer.pal(5, "Set2")
    
    # Render a barplot  
    barplot(height=bar$value, names=bar$review,
            ylim=c(0,5), main = b_name,
            col=coul,
            width=c(0.3,0.3,0.3,0.3,0.3))
    
  })
}
# Run the application 
shinyApp(ui, server)
