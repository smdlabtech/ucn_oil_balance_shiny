# Repository Schema  


```bash
/app/
│── app.R                # Point d'entrée de l'application
│── global.R             # Chargement des données et fonctions communes
│── ui.R                 # Interface utilisateur (appel des modules)
│── server.R             # Logique serveur (appel des modules)
│── modules/             # Dossier contenant les modules
│   ├── mod_home.R           # Module pour la page "Home"
│   ├── mod_stats.R          # Module pour "Statistiques Descriptives"
│   ├── mod_correlation.R    # Module pour "Matrice de Corrélation"
│   ├── mod_acp.R           # Module pour "Analyse en Composantes Principales"

```

