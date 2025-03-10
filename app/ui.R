library(shiny)
source("modules/mod_home.R")
source("modules/mod_stats.R")
source("modules/mod_correlation.R")
source("modules/mod_acp.R")

ui <- navbarPage("Analyse Pétrolière",
  tabPanel("Accueil", mod_home_ui("home")),
  tabPanel("Statistiques Descriptives", mod_stats_ui("stats")),
  tabPanel("Matrice de Corrélation", mod_correlation_ui("correlation")),
  tabPanel("Analyse en Composantes Principales", mod_acp_ui("acp"))
)
