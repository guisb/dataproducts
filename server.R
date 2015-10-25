library(shiny)
library(forecast)
library(markdown)


data <- readRDS("le.rds")

 
shinyServer(function(input, output) {

		dataforecast <- reactive({
			countryData <- subset(data[order(data$year), ], country == input$country)
			dataforecast <- ts(data = countryData$SP.DYN.LE00.IN, start=1980, end=2013)
			})
   
		datatable <- reactive({
			datatable <- subset(data[order(data$year), ], country == input$country)
			datatable <- datatable[c(4,3,2,1)]
			})
   
   
		output$table <- renderDataTable({
				datatable()
			}, options = list(include.rownames=FALSE, searching = FALSE,  AutoWidth=1, lengthChange=0, pageLength = 15, aoColumnDefs = list(list(sWidth=c("100px"))))
			)		
			
			

		output$arimaPlot <- renderPlot({
			fit_arima <- auto.arima(dataforecast())
			plot(forecast(fit_arima, h=input$years),  plot.conf=TRUE, shaded=TRUE, col="#166BE2", fcol=4)
			})


		output$etsPlot <- renderPlot({
			fit_ets <- ets(dataforecast())
			plot(forecast(fit_ets, h=input$years), plot.conf=TRUE, shaded=TRUE, col="#166BE2", fcol=4)
		})

  
		output$decompPlot <- renderPlot({
			fit <- ts(dataforecast(), frequency=12)
			fit_decomp <- decompose(fit)
			plot(fit_decomp, col="#166BE2")
		})
   
   
   
})