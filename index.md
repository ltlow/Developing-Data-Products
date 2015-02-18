---
title       : Developing Data Products
subtitle    : Air Passengers Predictor
author      : 
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [] # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

##  Introduction 

The Air Passengers Predictor is a shiny application designed to predict the number of air passengers for the classic Box & Jenkins airline, based on the dataset 'AirPassengers' provided in R.

The dataset contains monthly totals of international airline passengers from 1949 to 1960. 

The application can be accessed with following link: 

http://ltlow.shinyapps.io/AirPassengersPredictor

##  How to use it?

Simply select a year in the drop-down menu to predict the number of air passengers for that year and the result will be displayed.  To view the graph, click on the plot tab.

Eg. To predict the number of air passengers for year 2015, simply select 2015 in the drop-down menu and the result will be shown, then click on the 'plot' tab to see the graph.

--- .class #id

##  How it is built?

The full code in server.r and ui.r can be obtained from the github with the following link:

https://github.com/ltlow/Developing-Data-Products


The main code that dealt with the prediction is as follows:

```r
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
```


--- .class #id


```r
  x = 2015
  set.seed(1234)                   # set seed for reproducibility
  
  trainset = sample(1:9, replace = FALSE)   # spilt data set into training and test sets
  APTrain <- APSumToYr2[trainset, ]
  APTest <- APSumToYr2[-trainset, ]
  
  model1 <- lm(AirPassengers~X, APTrain)  # second model from train set
  
  predTest <- predict(model1, APTest, interval='prediction', level = .95 ) # run on test set
 
  z <- PreAP['Y'][PreAP$Yr==x, ]    # for prediction year reference
  
  result <- coef(model1)[2]*z + coef(model1)[1]       # apply into prediction
  result1 <- round(result, 0)
  result1
```

```
##     X 
## 25120
```

--- .class #id

##  Conclusion

The Air Passengers Predictor is a simple application developed to predict the number of air passengers for the classic Box & Jenkins airline.

However, it is only a proxy predictor as the data provided is from 1949 to 1960 which is quite far from the years for prediction. It may be more accurate in the prediction if more recent data is collected.






