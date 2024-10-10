# Install necessary packages if you haven't already
# install.packages("shiny")
# install.packages("quantmod")
# install.packages("dplyr")
# install.packages("shinythemes")
# install.packages("fontawesome")

library(shiny)
library(quantmod)
library(dplyr)
library(shinythemes)
library(fontawesome)  # For icons

# Define the UI for the Shiny app
ui <- fluidPage(
  theme = shinytheme("cosmo"),  # Choosing a sleek theme
  
  # Application title
  titlePanel(
    div(style = "text-align: center; color: #1F4E79;",
        icon("chart-line", class = "fa-lg"), "Live Forex Profit Calculator"
    )
  ),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      h4("Forex Trading Input", style = "color: #1F4E79; font-weight: bold;"),
      textInput("forex_pair", 
                label = "Enter Forex Pair (e.g., EURUSD=X, GBPUSD=X):", 
                value = "EURCHF=X",
                placeholder = "e.g., EURUSD=X"),
      helpText("Use the proper format for forex pairs, e.g., EURUSD=X for Euro/USD."),
      
      numericInput("investment", 
                   label = "Investment Amount (in base currency):", 
                   value = 1000, 
                   min = 1),
      helpText("This is your initial investment in the base currency."),
      
      numericInput("lot_size", 
                   label = "Lot Size (e.g., 1 for 100,000 units):", 
                   value = 1, 
                   min = 0.01),
      helpText("1 standard lot = 100,000 units."),
      
      numericInput("pip_change", 
                   label = "Expected Pip Change:", 
                   value = 50, 
                   min = 1),
      helpText("The expected price movement in pips."),
      
      actionButton("calculate", "Calculate Profit", 
                   icon = icon("calculator"),
                   style = "background-color: #1F4E79; color: white; width: 100%;")
    ),
    
    # Main panel layout with Forex Data and Profit Calculation vertically stacked
    mainPanel(
      fluidRow(
        column(12,
               h4("Live Forex Data", style = "color: #1F4E79; font-weight: bold;"),
               div(style = "background-color: #F9F9F9; padding: 20px; border-radius: 10px; margin-bottom: 20px;",
                   verbatimTextOutput("forex_data"))
        ),
        column(12,
               h4("Profit Estimation", style = "color: #1F4E79; font-weight: bold;"),
               div(style = "background-color: #F9F9F9; padding: 20px; border-radius: 10px;",
                   verbatimTextOutput("profit"))
        )
      )
    )
  )
)

# Define the server logic for the Shiny app
server <- function(input, output) {
  observeEvent(input$calculate, {
    
    # Fetch Forex data from Yahoo Finance using quantmod
    forex_data <- tryCatch({
      getQuote(input$forex_pair)
    }, error = function(e) {
      return(NULL)
    })
    
    output$forex_data <- renderPrint({
      if (is.null(forex_data)) {
        "Error: Unable to fetch forex data. Please check the forex pair."
      } else {
        forex_data
      }
    })
    
    # Updated profit calculation
    output$profit <- renderPrint({
      if (is.null(forex_data)) {
        return("No calculation due to missing Forex data.")
      } else {
        current_price <- forex_data$Last[1]  # Get the latest price (in USD for EUR/USD pair)
        
        # Lot size in units (1 lot = 100,000 units for EURUSD)
        lot_units <- input$lot_size * 100000
        
        # Pip value in USD (for EUR/USD, 1 pip = 0.0001 USD per unit traded)
        pip_value <- 0.0001 * lot_units
        
        # Profit in USD
        profit_usd <- pip_value * input$pip_change
        
        # Convert profit from USD to Euros (since EUR is the base currency)
        profit_eur <- profit_usd / current_price
        
        # Display the profit
        paste("For an investment of", input$investment, "in the pair", input$forex_pair,
              "with a pip change of", input$pip_change, "pips and lot size of", input$lot_size,
              "you could potentially earn a profit of:", round(profit_eur, 2), "EUR.")
      }
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
