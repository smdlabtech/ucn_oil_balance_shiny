library(shiny)
library(FactoMineR)
library(ggplot2)
library(readxl)


# Charger les données
# file <- "C:/Users/DASY/Downloads/ucn_oil_balance_R/_data/BilanGpePetrolier.xlsx"
# BD <- read.csv2(file, header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = c("", " ", "NA", "N/A"), row.names = 1)
# attach(BD)


# Charger les données
file <- "C:/Users/DASY/Downloads/ucn_oil_balance_R/_data/BilanGpePetrolier.xlsx"
BD <- read_excel(file)
attach(BD)


#----------------------------------------#
# Definition des fonctions dans le code
#-----------------------------------------#

# Fonction pour réaliser l'ACP
perform_pca <- function(data) {
  res.ACP <- PCA(data, scale.unit = TRUE, ncp = 5, graph = FALSE)
  return(res.ACP)
}

# Calculer la matrice de corrélation
correlation_matrix <- function(data) {
  cor_matrix <- cor(data, use = "complete.obs") # utilise 'complete.obs' pour gérer les valeurs manquantes
  return(cor_matrix)
}

# Interpréter la matrice de corrélation
interpret_correlation_matrix <- function(cor_matrix) {
  interpretation <- ""
  for(i in 1:nrow(cor_matrix)) {
    for(j in i:ncol(cor_matrix)) {
      if(i != j && abs(cor_matrix[i, j]) > 0.5) {
        interpretation <- paste0(interpretation, "\nLa variable ", colnames(cor_matrix)[i], 
                               " est fortement corrélée avec la variable ", colnames(cor_matrix)[j], ".")
      }
    }
  }
  return(interpretation)
}



#---------------------------------#
# UI : User Interface
#--------------------------------#
ui <- fluidPage(
  titlePanel("Analyse du bilan d'un Groupe Pétrolier de 1969 à 1984"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Sélectionnez une variable à analyser:", choices = colnames(BD))
      
      # ,actionButton("analyze", "Analyser")
    ),
    
    
    mainPanel(
      tabsetPanel(
        
        
        tabPanel("Statistiques Descriptives",
                 plotOutput("histogram"),
                 tableOutput("summary")
                 ),
        
        tabPanel("Matrice de Corrélation",
                 verbatimTextOutput("correlation_matrix"),
                 htmlOutput("correlation_interpretation")
                 ),
  
        
        tabPanel("Analyse en Composantes Principales",
                 plotOutput("pca_individuals"),
                 plotOutput("pca_variables"),
                 verbatimTextOutput("pca_interpretation")
                 )

      )
    )
  )
)


#--------------------#
# SERVER :
#--------------------#
server <- function(input, output) {
  # Réaliser l'ACP
  res.ACP <- reactive({
    perform_pca(BD)
  })
  
  # Afficher les statistiques descriptives
  output$histogram <- renderPlot({
    hist(BD[[input$variable]], col = "orange", main = paste(input$variable), ylab = "Effectifs", xlab = "Valeurs annuelles")
  })
  
  output$correlation_matrix <- renderPrint({
    correlation_matrix(BD)
  })

  output$correlation_interpretation <- renderText({
    cor_matrix <- correlation_matrix(BD)
    interpretation <- interpret_correlation_matrix(cor_matrix)
    interpretation <- gsub("\n", "<br>", interpretation) # Remplacer les sauts de ligne par des balises HTML <br>
    interpretation
  })

  output$summary <- renderTable({
    summary(BD)
  })
  
  # Afficher les graphiques de l'ACP
  output$pca_individuals <- renderPlot({
    plot.PCA(res.ACP(), axes = c(1, 2), choix = "ind", label = "ind", new.plot = TRUE)
  })
  
  output$pca_variables <- renderPlot({
    plot.PCA(res.ACP(), axes = c(1, 2), choix = "var", new.plot = TRUE, col.var = "black", label = "var")
  })
  

  # Afficher l'interprétation de l'ACP
  output$pca_interpretation <- renderPrint({
    cat("## Interprétation de l'ACP\n\n")
    cat("### Axe 1:\n\n")
    cat("Les variables NET, SUB, DCT, IMM et EXP contribuent le plus à la formation de l'axe 1.\n")
    cat("L'axe 1 oppose les années avant le choc pétrolier de 1973 (1969-1972) aux années après 1982.\n\n")
    cat("### Axe 2:\n\n")
    cat("Les variables INT, VRD et LMT contribuent le plus à la formation de l'axe 2.\n")
    cat("L'axe 2 sépare les années entre les deux chocs pétroliers (1975-1978) des autres années.\n")
  })
}

# Lancer l'application
shinyApp(ui = ui, server = server)
