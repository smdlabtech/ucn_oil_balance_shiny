# 🛢️ OIL BALANCE ANALYSIS  
![Data Science](https://img.shields.io/badge/Data_Science-Analytics-green?style=flat&logo=python)
![PCA](https://img.shields.io/badge/Dimensionality_Reduction-PCA-blueviolet?style=flat&logo=r)
![Finance](https://img.shields.io/badge/Financial_Analysis-Economic_Data-orange?style=flat&logo=graphviz)

📌 **NB** : Pour voir l'étude plus en détail, consultez les fichiers :  
- 📄 **DM_Mr_Ses.Rmd**  
- 📄 **DM_Mr_Ses.pdf**  

---

## 📊 Analyse du bilan d'un groupe pétrolier (1969 - 1984)  

Cette étude porte sur l'analyse des bilans annuels d'un **groupe pétrolier** sur la période **1969 à 1984**.  
Les postes du bilan sont décrits et analysés afin de mieux comprendre leur évolution sur 15 ans.  

📌 **Objectifs de l'analyse**  
- Étudier l'évolution des structures financières sur 15 ans  
- Identifier les différentes périodes marquantes  
- Réaliser une **Analyse en Composantes Principales (ACP)** pour détecter des tendances  

---

## 📖 Table des matières  
- [💾 Installations](#install)  
- [📂 Présentation des données](#presentation)  
- [📊 Statistiques descriptives](#descriptive)  
- [📈 Réalisation d'une ACP](#pca)  
- [🏆 Sponsors](#sponsors)  

---

<h2 id="install">💾 Installations</h2>  

Avant de commencer, assurez-vous d'avoir installé les packages suivants dans **R** :  

```r
install.packages(c("knitr", "dplyr", "FactoMineR"))
```

---

<h2 id="presentation">📂 Présentation des données</h2>  

Les données étudiées proviennent des **bilans annuels d’un groupe pétrolier** entre **1969 et 1984**.  
Elles ont été exprimées en **pourcentage annuel** pour éviter les effets liés à l'inflation.  

📌 **Description des variables**  
- **NET** : Capitaux propres  
- **INT** : Frais financiers (intérêts)  
- **SUB** : Subventions de l'État  
- **LMT** : Dettes à long et moyen terme  
- **DCT** : Dettes à court terme  
- **IMM** : Immobilisations (terrains, matériel)  
- **EXP** : Valeurs d’exploitation  
- **VRD** : Valeurs réalisables et disponibles  

📂 **Chargement des données en R**  

```r
library(FactoMineR)

# Importation des données
file <- "C:/Users/mamad/Dropbox/Alpha_docs/Ana_donnees/DM/BilanGpePetrolier.csv"
BD <- read.csv2(file, header = TRUE, sep = ";", stringsAsFactors = FALSE,
                na.strings = c("", " ", "NA", "N/A"), row.names = 1)

attach(BD)
BD
```

📌 **Questions d'analyse**  
- 🔍 **Quelle a été l'évolution de la structure du bilan sur 15 ans ?**  
- 🔍 **Peut-on identifier différentes périodes ? Si oui, comment se caractérisent-elles ?**  

---

<h2 id="descriptive">📊 Statistiques descriptives</h2>  

```r
summary(BD)
```

📌 **Observations clés**  
- Certaines variables comme **INT, LMT, NET, SUB et VRD** ont des moyennes supérieures à leurs médianes.  
- Cela suggère que plus de **50% des valeurs** de ces variables sont inférieures à leurs moyennes respectives.  

---

<h2 id="pca">📈 Réalisation d'une ACP centrée-réduite</h2>  

📌 **Analyse des composantes principales** en R  

```r
library(FactoMineR)

# ACP sur les données centrées et réduites
pca_result <- PCA(BD, scale.unit = TRUE, graph = TRUE)
```

📊 **Interprétation des axes principaux**  
- L’ACP permet de détecter des **corrélations fortes** entre les variables.  
- Les premières composantes principales expliquent la **variabilité des structures financières** du groupe pétrolier.  

📌 **Visualisation des résultats**  

```r
plot.PCA(pca_result, axes = c(1, 2))
```

---

<h2 id="sponsors">🏆 Sponsors</h2>  

✨ **Développé par [SMD Lab Tech](https://github.com/smdlabtech)**  
📧 Contact : smdlabtech@gmail.com  

---
📜 **Licence** : Open-Source  

---
