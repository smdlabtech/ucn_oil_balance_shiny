

mod_correlation_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tableOutput(ns("correlation_matrix"))
  )
}

mod_correlation_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$correlation_matrix <- renderTable({
      correlation_matrix(BD)
    }, rownames = TRUE)
  })
}
