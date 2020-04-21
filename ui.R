library("shiny")

#page setup
ui <- fluidPage(
  
  # Application title
  titlePanel("Time Series Autoregressive Model Simulation Plots"),
  
  #select the lag for the autoregressive model, defaults to 1
  sidebarLayout(
    sidebarPanel(
      selectInput("lag", "Choose a Lag:",
                  choices = c("1", "2", "3"),
                  selected = "1")
      ,
      
      #select the paramater value for alpha
      sliderInput("alph",
                  "Alpha:",
                  min = -2,
                  max = 2,
                  value = 0, step = 0.0001),
      
      #if lag >=2 then show the paramater selection for beta
      conditionalPanel(condition = "input.lag >= 2",
                       sliderInput(inputId = "bet", label = "Beta:",
                                   min = -2, max = 2, value = 0, step = 0.0001 ) ),
      
      #if lag = 3 then show the parameter selection for gamma
      conditionalPanel(condition = "input.lag == 3",
                       sliderInput(inputId = "gam", label = "Gamma:",
                                   min = -2, max = 2, value = 0, step = 0.0001 ) )
      
      #get user input for time points
      , sliderInput("time", "Select the Amount of Time Points", min = 1, max = 200, value = 200,            step = 1)
    )
    ,
    
    
    # Show plot then show text 
    mainPanel(
      plotOutput("ARPlot")
      ,htmlOutput("explanation")
    )
  ))