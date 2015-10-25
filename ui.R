library(shiny)
library(forecast)
library(markdown)


shinyUI(fluidPage(

  headerPanel("Forecasting Life Expectancy at Birth"),

 
  sidebarPanel(
    helpText("Life Expectancy at Birth forecast for the top ten countries classified by the World Bank, using the size of its Gross Domestic Product."),
    br(),

    selectInput("country", "Country",
                choices = c(
                            "United States",
                            "China",
                            "Japan",
                            "Germany",
							"United Kingdom",
							"France",
							"Brazil",
							"Italy",
							"India",
							"Russia"
                            ),
                selected = "United States"
    ),
    sliderInput("years", "Number of years for forecasting:",
                min = 1, max = 20, value = 1),
				
    submitButton("Forecast"),	

  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
    
  HTML("<strong>Instructions: </strong>"),
  
  helpText("1 - Choice the country."), 
  helpText("2 - Set the number of years for forecasting."), 
  helpText("3 - Explore each one of the tabs: Arima, ETS and decomposition."),
    
  br(),
  
  helpText("See the documentation in the last tab."),
  helpText(p("The code and data are available at ",
             a(href ="https://github.com/guisb/dataproducts", "this GitHub page",target = "_blank")
             )),
   
  
  br()
  	
  ),
    mainPanel(
      tabsetPanel(
	    tabPanel("Data", dataTableOutput("table")), 
		tabPanel("ARIMA", plotOutput("arimaPlot")),
		tabPanel("ETS", plotOutput("etsPlot")), 
		tabPanel("Decomposition", plotOutput("decompPlot")),
        tabPanel("Documentation", includeMarkdown("doc.md"))
      )
    )
  )
)
