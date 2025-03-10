

mod_home_ui <- function(id) {
  ns <- NS(id)
  tagList(
    titlePanel("Bienvenue"),
    p("Cette application permet d'analyser le bilan pétrolier de 1969 à 1984."),
    p("Utilisez les onglets ci-dessus pour naviguer entre les analyses.")
  )
}

mod_home_server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}
