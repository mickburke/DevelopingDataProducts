library(reshape2)
library(plotly)
library(ggplot2)
library(dplyr)
library(markdown)

shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({

    df <- read.csv("OpenDataTaxReceiptsSource.csv")

    df %>% 
      group_by(Year, Entry.Type, Tax.Type) %>% 
      summarize(Total = sum(Amount) / 1000000) %>%
      filter(Tax.Type %in% input$taxType,
             Year %in% seq(input$years[1], 
                           input$years[2]),
             Entry.Type %in% "Actual Outturn")
    
      })
  
  output$plot1 <- renderPlotly({
    ggplot(selectedData(), 
           aes(x = Year, 
               y = Total, 
               color = Tax.Type,
               group = Tax.Type)) +
    geom_line(size = 2, alpha = 0.5) + 
    geom_point(size = 2) +
    theme(text = element_text(size = 10),
          legend.position = 'bottom') + 
    labs(x="Year", y="Amount (billions of euro)")
    
  })
  
})