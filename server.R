

library(shiny)




# Define server logic
server <- function(input, output) {
   
  #create the plot output 
   output$ARPlot <- renderPlot({
     
     
     X <- rep(0, 200)
     
     #get user input for the model parameters
     alph <- input$alph
     bet <- input$bet
     gam <- input$gam
     
     #AR_1 model, choice of X_0 is a normal random variable
     if (input$lag == "1") {
     for (i in 2:200) {
       X[1] <- 0+rnorm(1)
       X[i] <- alph*X[i-1] + rnorm(1)
     }
     
     }
     #AR_2 model, choice of X_0 and X_1 are both 1 to have a nice "fibonacci" type pattern when          parameters are appropriate
     else if (input$lag == "2") {
       for (i in 3:200) {
         X[1] <- 1
         X[2] <- 1
         X[i] <- alph*X[i-1] + bet*X[i-2]+ rnorm(1)
       }
       
     }
     #AR_3 model
     else if (input$lag == "3") {
       for (i in 4:200) {
         X[1] <- 1+rnorm(1)
         X[2] <- 1+rnorm(1)
         X[3] <- 1+ rnorm(1)
         X[i] <- alph*X[i-1]+bet*X[i-2]+gam*X[i-3] + rnorm(1)
       }
       
     }
     
     #create plot with connecting lines
     plot(1:input$time, 3.5+ X[1:input$time], xlab = "Time", ylab = "X", main = "")
     lines(1:input$time, 3.5+X[1:input$time])
   })
   
   #explanation of model
   output$explanation <- renderText({
     "<p style=font-size:20px>The autoregressive models used for these time series simulations are for time points t: <br> <br> </p>
    <p style=font-size:20px;color:DarkTurquoise> For Lag-1: X <sub> t </sub> = &alpha; X <sub> t-1 </sub> + &epsilon; <sub> t </sub> <br> <br> </p>
    <p style=font-size:20px;color:DeepSkyBlue> For Lag-2: X <sub> t </sub> = &alpha; X <sub> t-1 </sub> + &beta; X <sub> t-2 </sub> + &epsilon; <sub> t </sub> <br> <br> </p>
   <p style=font-size:20px;color:DodgerBlue> For Lag-3: X <sub> t </sub> = &alpha; X <sub> t-1 </sub> + &beta; X <sub> t-2 </sub>+ &gamma; X <sub> t-3 </sub> + &epsilon; <sub> t </sub> <br>
     </p>"
        
   }
     
   )
}


