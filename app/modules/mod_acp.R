mod_acp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(6, plotOutput(ns("pca_individuals"))),
      column(6, plotOutput(ns("pca_variables")))
    ),
    verbatimTextOutput(ns("pca_interpretation"))
  )
}

mod_acp_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    res.ACP <- reactive({ perform_pca(BD) })
    
    output$pca_individuals <- renderPlot({
      plot.PCA(res.ACP(), axes = c(1, 2), choix = "ind", label = "ind", new.plot = TRUE)
    })
    
    output$pca_variables <- renderPlot({
      plot.PCA(res.ACP(), axes = c(1, 2), choix = "var", col.var = "black", label = "var", new.plot = TRUE)
    })
    
    output$pca_interpretation <- renderPrint({
      cat("## Interprétation de l'ACP\n\n")
      cat("### Axe 1:\n")
      cat("Les variables NET, SUB, DCT, IMM et EXP contribuent le plus à l'axe 1.\n")
      cat("L'axe 1 oppose les années avant le choc pétrolier de 1973 (1969-1972) aux années après 1982.\n\n")
      cat("### Axe 2:\n")
      cat("Les variables INT, VRD et LMT contribuent le plus à l'axe 2.\n")
      cat("L'axe 2 sépare les années entre les deux chocs pétroliers (1975-1978) des autres années.\n")
    })
  })
}
