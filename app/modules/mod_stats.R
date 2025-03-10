mod_stats_ui <- function(id) {
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("variable"), "Sélectionnez une variable :", choices = colnames(BD))
      ),
      mainPanel(
        plotOutput(ns("histogram")),
        tableOutput(ns("summary"))
      )
    )
  )
}

mod_stats_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$histogram <- renderPlot({
      validate(need(input$variable %in% colnames(BD), "Sélectionnez une variable valide."))
      hist(BD[[input$variable]], col = "orange", main = paste("Histogramme de", input$variable),
           ylab = "Effectifs", xlab = "Valeurs annuelles")
    })
    
    output$summary <- renderTable({
      summary(BD[[input$variable], drop = FALSE])
    })
  })
}
