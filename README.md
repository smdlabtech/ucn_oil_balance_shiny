(_**NB** : Pour voir l'étude plus en détail voir le fichier : DM_Mr_Ses.Rmd ou le fichier DM_Mr_Ses.pdf_)  
(Markdown en cours d'édition...)

# Analyse du bilan d'un groupe pétrolier de 1969 à 1984 
Les données étudiées sont issues des bilans annuels d'un groupe pétrolier sur la période 1969 à 1984.   
Les postes du bilan qui suivent chaque année y sont bien décrits.  

# Table des matières
- [Installations](#install)
- [Présentation des données](#presentation)
- [Statistiques descriptives](#descriptive)
- [Réalisation d'une ACP](#pca)
- [Sponsors](#sponsors)


<h2 id="install">Installations</h2>
Installation de packages et chargement :

```
install.packages('knitr')
install.packages('dplyr')
install.packages('FactoMineR')
```

<h2 id="presentation">Présentation des données</h2>
Les données étudiées sont issus des bilans annuels d'un groupe pétrolier sur la période
1969 à 1984. Les postes de bilans suivant chaque année sont décrit ci-dessous:
  
  * **_NET_** : Situation nette ; représente l'ensemble des capitaux propres de l'entreprise
  * **_INT_** : Intérêts ; représente l'ensemble des frais financiers supportés par l'entreprise.
  * **_SUB_** : Subventions ; représente le montant total des subventions accordées par l'état.
  * **_LMT_** : Dettes à long et moyen terme.
  * **_DCT_** : Dettes à court terme.
  * **_IMM_** : Immobilisations ; représente l'ensemble des terrains et du matériel de l'entreprise.
  * **_EXP_** : Valeurs d'exploitation.
  * **_VRD_** : Valeurs réalisables et disponibles ; ensemble des créances à court terme de l'entreprise.

Les données sont de nature quantitatives et ont été ventilées en pourcentage par année, la somme des éléments d'une même
ligne vaut 100, de manière à éviter les effets dus à l'inflation.
Et elles se présentent sous la forme suivante:

```{r, echo=FALSE}
library(FactoMineR)
#I) Importations, Nettoyages et Validations des donnees
file="C:/Users/mamad/Dropbox/Alpha_docs/Ana_donnees/DM/BilanGpePetrolier.csv"
BD <- read.csv2(file,header = TRUE, sep = ";",stringsAsFactors = FALSE,
                na.strings = c(""," ","NA","N/A"),row.names=1)
attach(BD)
BD
```
Dans la suite de notre analyse, nous tenterons d'apporter des éléments de réponse aux questions suivantes:
  * **_Quelle a été l'évolution de la structure de bilan sur 15 ans ?_**
  * **_Peut-on mettre en évidence plusieurs périodes ? Si oui, comment se caractérisent-elles ?_**



<h2 id="descriptive">Statistiques descriptives</h2>

```{r, echo=TRUE}
summary(BD)
```

Nous notons d'abord qu'il n'y a pas de symétrie des variables.
Seulement nous avons les variables INT, LMT, NET, SUB et VRD qui ont des moyennes supérieures à leurs médianes respectives.
Ce qui permet de dire qu'il y a plus de 50% des valeurs de chacune de ces variables respectives qui sont inférieures à leurs moyennes respectives.



<h2 id="pca">Réalisation d'une ACP centrée réduite </h2>


<h2 id="sponsors">

  Sponsors 🏆

</h2>

> @smdlabtech - **UCN : Université de Caen Normandie**



