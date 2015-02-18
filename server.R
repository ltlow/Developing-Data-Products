library(shiny)

shinyServer(
  function(input, output) {
    output$x <- renderText(input$x)
    output$PredictedResult <- renderPrint({PredictedResult(input$x)})
    output$myPlot <- renderPlot({Plot(input$x)})
  })

library(datasets)            # get dataset
APData <- AirPassengers

APSumToYr <- aggregate(APData, FUN=sum)   # re-arrange dataset
APSumToYr1 <- data.frame(APSumToYr)
names(APSumToYr1) <- c("AirPassengers")
X <- 0:11
Year <- 1949:1960
APSumToYr2 <- cbind(X, Year, APSumToYr1)

Y <- 12:76                        # create new dataset for prediction year reference
Yr <- seq(1961,2025, 1)
PreAP <- data.frame(Y,Yr)

modelData <- lm(AirPassengers~X,APSumToYr2)     # first model
summary(modelData)

set.seed(1234)                   # set seed for reproducibility

trainset = sample(1:9, replace = FALSE)   # spilt data set into training and test sets
APTrain <- APSumToYr2[trainset, ]
APTest <- APSumToYr2[-trainset, ]

model1 <- lm(AirPassengers~X, APTrain)  # second model from train set
summary(model1)

predTest <- predict(model1, APTest, interval='prediction', level = .95 ) # run on test set

# Prediction function
PredictedResult <- function (x) {

  z <- PreAP['Y'][PreAP$Yr==x, ]    # for prediction year reference
  
  result <- coef(model1)[2]*z + coef(model1)[1]       # apply into prediction
  result1 <- round(result, 0)
  result1
}

# Plot function
Plot <- function (x) {

  z <- PreAP['Y'][PreAP$Yr==x, ]    # obtain data for plot
  result <- coef(model1)[2]*z + coef(model1)[1]       
  result1 <- round(result, 0)
  
  RevAP <- data.frame(z, x, result1)   # create new dataframe for result
  names(RevAP) <- c("X", "Year", "AirPassengers")  # name the new dataframe
  RevAP1 <- rbind(RevAP, APSumToYr2)    # rbind the new and old dataframes
    
  library(ggplot2)                            # plot graph
  ggplot(RevAP1, aes(x=X, y=AirPassengers)) +     
    geom_point(shape=1) +    # use hollow circles
    geom_smooth(method=lm,   # add linear regression line
                se=FALSE) +
    xlab("Year") 
}