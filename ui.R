library(shiny)

shinyUI(fluidPage(
titlePanel(title = "Air Passengers Predictor"),

p("This is a shiny application built based on the R dataset 'AirPassengers' to predict the annual number of air passengers for the classic Box & Jenkins airline. "),

p("To use it, simply select a year in the drop-down menu for prediction and the result will be displayed.  To view the graph, click on the 'plot' tab."),

br(),

sidebarLayout(
sidebarPanel(
  selectInput("x", "Select a year for prediction", c("2015", "2016", "2017", "2018", "2019", "2020","2021", "2022", "2023", "2024", "2025"), selected="2015")
    ), 
mainPanel(

  tabsetPanel(type="tab",
              tabPanel("Result",("You have entered year [x]:"),
                                verbatimTextOutput("x"),
                                ("Predicted number of air passengers for year x :"),
                                verbatimTextOutput("PredictedResult")),
              tabPanel("Plot", plotOutput("myPlot"))
    )) 
)))
