library(plotly)

shinyUI(
  navbarPage("Irish Taxation Explorer",
             tabPanel("Plot",
                      sidebarPanel(
                        sliderInput("years",
                                    "Years:",
                                    min = 1984,
                                    max = 2017,
                                    value=c(1984, 2017),
                                    sep=""),
                        checkboxGroupInput('taxType', 'Tax Type', 
                                           choices = c('Customs',
                                                       'Excise Duty',
                                                       'Capital Gains Tax',
                                                       'Stamps', 
                                                       'Income Tax',
                                                       'Corporation Tax',
                                                       'Valued Added Tax',
                                                       'Training and Employment Levy',
                                                       'Motor Vehicle Duties',
                                                       'Unallocated Tax Receipts',
                                                       'Capital Acquisitions Tax',
                                                       'Local Property Tax'
                                           ),
                                           selected = 'Income Tax')
                      ),
                      mainPanel(
                        plotlyOutput('plot1')
                      )                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("include.md")
                      )
             )
  )
)