library(shiny)
library(FactoMineR)
library(ggplot2)
library(readxl)

# Chargement des données
file <- "C:/Users/DASY/Downloads/ucn_oil_balance_R/_data/BilanGpePetrolier.xlsx"
BD <- read_excel(file)

# Fonction ACP
perform_pca <- function(data) {
  PCA(data, scale.unit = TRUE, ncp = 5, graph = FALSE)
}

# Matrice de corrélation
correlation_matrix <- function(data) {
  cor(data, use = "complete.obs")
}
