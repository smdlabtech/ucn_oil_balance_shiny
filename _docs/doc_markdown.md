
**Title**: *"Analyse du bilan d'un Groupe Pétrolier de 1969 é 1984"*   
**Author**: *"Daya SMD Lab-Tech"*  
**date**: *"Date : 15-05-2021"*    
**language**: *"rmarkdown"*    

# OIL BALANCE ANALYSIS

```{r setup, include=FALSE, message=FALSE, warning=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

##  1. Présentations

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
file="C:/Users/mamad/Dropbox/Alpha_docs/Ana_donnees/BilanGpePetrolier.csv"
BD <- read.csv2(file,header = TRUE, sep = ";",stringsAsFactors = FALSE,
                na.strings = c(""," ","NA","N/A"),row.names=1)
attach(BD)
BD
```

Dans la suite de notre analyse, nous tenterons d'apporter des éléments de réponse aux questions suivantes:
  
  * **_Quelle a été l'évolution de la structure de bilan sur 15 ans ?_**
  * **_Peut-on mettre en évidence plusieurs périodes ? Si oui, comment se caractérisent-elles ?_**


## 2. Statistiques Descriptives

```{r, echo=TRUE}
summary(BD)
```

Nous notons d'abord qu'il n'y a pas de symétrie des variables.
Seulement nous avons les variables INT, LMT, NET, SUB et VRD qui ont des moyennes supérieures à leurs médianes respectives.
Ce qui permet de dire qu'il y a plus de 50% des valeurs de chacune de ces variables respectives qui sont inférieures à leurs moyennes respectives.

#### 2.1 Histogrammes de l'évolution du bilan :

```{r, echo=TRUE}
par(mfrow=c(2,4))
hist(BD$NET, col = c("orange"),main = paste("NET"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$INT, col = c("orange"),main = paste("INT"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$SUB, col = c("orange"),main = paste("SUB"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$LMT, col = c("orange"),main = paste("LMT"),ylab = "Effectifs",xlab = "Valeurs annuelles")

#par(mfrow=c(2,2))
hist(BD$DCT, col = c("orange"),main = paste("DCT"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$IMM, col = c("orange"),main = paste("IMM"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$EXP, col = c("orange"),main = paste("EXP"),ylab = "Effectifs",xlab = "Valeurs annuelles")
hist(BD$VRD, col = c("orange"),main = paste("VRD"),ylab = "Effectifs",xlab = "Valeurs annuelles")

```

**Commentaires:**
Les graphes des variables IMM, INT, LMT, NET et VRD ont toutes des allures décroissantes.
Ces dernière nous informent qu'au cours de ces 15 années au sein dun groupe qu'il y'a eu une baisse:

  * des Immobilisations, 
  * des frais financiers supporter par l'entreprise,
  * des dettes à long et moyen termes,
  * de l'ensemble des capitaux propres de l'entreprise,
  * de l'ensemble des créances à court terme de l'entreprise.


Et quant aux variables DCT, EXP et SUB, elles ont connu une augmentation au fil du temps.

#### **2.2 Matrice de Corràlation :**

```{r, echo=TRUE}
MatCor<-round(cor(BD),4)
MatCor
```

Une relation linéaire positive existe entre les variables DCT et EXP. 
  
  * DCT et EXP, 0.8644

Une relation linéaire négative existe entre les variables DCT et NET,
DCT et IMM, EXP et IMM

  * DCT et NET, -0.8908
  * DCT et IMM, -0.8168
  * EXP et IMM, -0.9446
  * NET et EXP, -0.7045


**Valeurs propres:**
```{r, echo=TRUE}
eigen(MatCor)$values
```

**Vecteurs propres:**
```{r, echo=TRUE}
eigen(MatCor)$vectors
```

## 3. Réalisation de l'ACP centrée réduite

```{r, echo=TRUE}
library(FactoMineR)
res.ACP<-PCA(BD, scale.unit = TRUE, ncp=5, graph = FALSE) 
summary(res.ACP, nbind=16)

```

####  **3.1 Choix du nombre d'axes à retenir:**
#####  **Critère du Coude :**
```{r, echo=TRUE,fig.align='center'}
plot(res.ACP$eig[,1],type="o",main = "Eboulis de valeurs propres",
     xlab ="dimensions",ylab = "valeurs propres")
```
Le graphique de l'éboulis des valeurs propres montre un premier coude 
après la 2nde valeur, cependant après cette même 2nde valeur la décroissance de l'inertie beaucoup devient très faible. 
Naturellement, on ne s'intéressera donc qu'aux 2 premiers axes.

#####  **Critère de Kaiser :**
```{r, echo=TRUE}
res.ACP$eig[,1:3]
```
Le critère de Kaiser nous conduit de même à retenir que 2 axes, expliquant plus de **82%** de l'inertie totale.

**Conclusion :**

  * Le premier facteur est prépondérant, il conserve **55.87%** de l'inertie du nuage. Il est peu probable qu'il soit dû au hasard. Il existe une structuration importante des données qui va se manifester sur le premier axe (1/2 au lieu de 1/8).

  * Le second axe quand à lui, il conserve une part importante de l'inertie totale, soit **26.43%**. 
  
  * En effet, d'un côté, la chute d'inertie est très importante dès le troisième axe, qui ne conserve plus que **8.5%** de l'inertie totale.
  
Nous décidons dorénavant de ne retenir que les 2 premiers axes (le premier plan factoriel)  car il est compréhensible à l'oeil et ne déforme pas trop le nuage (il explique 82% de l'inertie du nuage).


####  **3.2 Graphiques :**
#####  **3.2.1 Graphiques des individus:**

```{r, echo=TRUE,fig.align='center'}
plot.PCA(res.ACP, axes=c(1, 2), choix="ind", label="ind",new.plot=TRUE)
```

#####  **3.2.2 Graphique des variables:**
```{r, echo=TRUE,fig.align='center'}
plot.PCA(res.ACP, axes=c(1, 2), choix="var", new.plot=TRUE, col.var="black", label="var")
```

####  **3.3 Interprétations :**

#####  **3.3.1 Analyse pour l'Axe 1:**

######  **_Individus (Contributions et Qualités de représentations):_**

```{r, echo=TRUE,fig.align='center'}
res.ACP$ind$contrib[,1:2] #Contributions
res.ACP$ind$cos2[,1:2]    #Qualités de représentations des individus sur les axes (Cos2)
```
En comparant les valeurs de la première colonne du tableau des contributions
à la racine de la première valeur propre sqrt(lambda)=sqrt(4.470445)=2.114343 .  

Nous voyons bien que les années **1969, 1970, 1971 1972** et **1982** contribuent le plus a la formation del'axe. En plus de leur bonne qualité de representation, les 4 premiers sont du même côté de l'axe. Tandis que l'année **1982** se trouve du côté opposé.

De plus, grâce au premier axe, nous identifions une opposition de
la structure de bilan l'année **1982** aux quatre années précédant
le choc pétrolier de 1973.(Voir PCA graph of individuals)  
Ainsi donc l'axe met la lumière sur les zones qui se dégagent
notamment l'avant et l'après le choc.

En plus des années contribuant fortement à l'axe, il y'a aussi les individus
**1973**, **1974**, **1981** et **1984** qui ont une bonne qualité de représentation.

######  **_Variables (Coordonnées et Contributions):_**

```{r, echo=TRUE,fig.align='center'}
res.ACP$var$coord[,1:2]     #Coordonnées
res.ACP$var$contrib[,1:2]/5 #Trier pour axe 1: contributions
```

Nous identifions les variables **NET**, **SUB**, **DCT**, **IMM**, **EXP** contribuant le plus à la formation de l'axe.
Les variables **NET** et **IMM** sont du même côté de l'axe tandis que **SUB**, **DCT** et **EXP** sont du côté opposé.

Contrairement aux autres variables dont la qualite de representation est moyenne,
Seules les variables LMT et VRD semblent ne pas être bien representés par l'axe.

#####  **3.3.2 Analyse pour l'Axe 2:**
######  **_Individus (Contributions et Qualités de représentations):_**
```{r, echo=TRUE,fig.align='center'}
res.ACP$ind$contrib[,1:2] #Contributions
res.ACP$ind$cos2[,1:2]    #Qualités de représentations des individus sur les axes (Cos2)
```

En comparant les valeurs de la première colonne du tableau des contributions
à la racine de la première valeur propre sqrt(lambda)=sqrt(2.114851)=1.454253

Nous obtenons les années **1969**, **1983**, **1975**, **1976**, **1977**, **1978** contribuent le plus a la formation de l'axe. En plus de leur bonne qualite de representation, les 2 premiers sont du même côté
de l'axe ,tandis que les 4 derniers se trouvent du côté opposé.

Ainsi le 2ème axe oppose les années de **1975** à **1978** aux années **1983** et **1969**.  
Les années 1975 à 1978 se trouvent entre 2 chocs pétroliers.
A noté que les années 83 et 69 sont assez mal représentées sur l'axe.

######  **_Variables (Coordonnées et Contributions):_**
```{r, echo=TRUE,fig.align='center'}
res.ACP$var$coord[,1:2]     #Coordonnées
res.ACP$var$contrib[,1:2]/5 #Contributions 
```
Nous comparons les valeurs de la colonne dim.2 à 35%

Nous identifions ainsi les variables **INT**, **VRD** et **LMT** contribuant le plus à la formation de l'axe.
Les 2 premières variables **INT** et **VRD** sont du même côté de l'axe tandis que **LMT** est du côté opposé.

Le reste des variables ne sont pas bien representés par l'axe, ils seront 
donc assez mal expliqué par le l'axe.

######  **_En Résumé:_**
L'axe 2 sépare les années entre les deux chocs, **1975** à **1978**,
caractérisées par un poids important du
poste **LMT** et un poids faible des postes **VRD** et **INT**.


#####  **3.3.3 Synthése Générale:**

######  **3.3.3.a) Qualité de représentation des individus sur le plan(1,2):**

```{r, echo=TRUE,fig.align='center'}
plot.PCA(res.ACP,habillage='cos2',title="Graphe des individus")
```
Les individus ne sont pas tous très bien représentés.
En effet, les individus coloriés en rouge sont ceux qui ont une très forte
représentation, ensuite en Violet ceux moyennement représentés et enfin
en bleu ceux qui ont une qualité de représentation faible.


######  **3.3.3.b) Qualité de représentation des variables sur le plan(1,2):**
```{r, echo=TRUE,fig.align='center'}
plot.PCA(res.ACP,choix='var',habillage = 'cos2',
         title="Graphe des variables")
```
Les variables non plus ne sont pas tous très bien représentés.
De même que les individus, nous avons en rouge sont ceux qui sont
fortement représentés, ensuite ceux moyennement représentés en Violet
et enfin les plus faibles en bleu.

######  **_En Résumé:_**
En observant bien le graphe des individus, nous distinguons trois groupes occupant trois zones.
Ce qui fait qu'il y'a naturellement trois périodes qui se dégagent:  
  
  * la période (1969-1973) précèdent le premier choc pétrolier qui est marquée par une Situation nette(**NET**) et des Immobilisations(**IMM**).

  * Le période de l'entre deux chocs (1975-1978), qui est marquée par les politiques d'endettement de long (**LMT**) et moyen terme(**DCT**).
  
  * et la période après chocs(après 1979), dans laquelle nous observons une augmentation des subventions(**SUB**) et des dettes à court termes (**DCT**).
  
