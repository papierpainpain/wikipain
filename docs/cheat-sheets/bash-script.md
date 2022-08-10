# Documentation Scripts bash

Documentation pas de moi mais de [Knayz](https://www.juliebousseau.fr/) ! xD

## 01 - Paramètres

`./monProgramme.sh toto titi`

```bash title="monProgramme.sh"
$1=toto
$2=titi
```

## 02 - Syntaxes et random

```bash
var=$((var+2)) # Calcul
currentDay_yyyymmdd=`echo $currentDay | sed -e "s/-//g"` # Lancer une commande (ici, del les - d'une variable)
currentDay_yyyymm="${currentDay_yyyymmdd:0:6}" # Garder les 6 premiers caractères

currentDay=`date +%F` # Jour au format yyyy-mm-dd

if [ ${#var} -eq 1 ] # Tester la taille d'une chaîne
```

## 03 - Structures conditionnelles

### 03.1 - Boucle si

```bash
if [ test ]
then
	instruction
elif [ test2 ]
then
	instruction
else
	instruction
fi
```

### 03.2 - Tests

```bash
$var1 -eq $var2 # Egal
$var1 -ne $var2 # Différent

$var1 -gt $var2 # Supérieur
$var1 -ge $var2 # Supérieur ou égal

$var1 -lt $var2 # Inférieur
$var1 -le $var2 # Inférieur ou égal

-z $1 # Variable vide
-n $1 # Variable non vide

-e $fichier # Fichier existe
-f $fichier # Fichier simple
-d $folder # Dossier
$f1 -nt $f2 # f1 plus récent
```

## 04 - Boucles

### 04.1 - Tant que

Structure :

```bash
while [ test ]
do
	instruction
done
```

!!! example "Exemple"
	```bash
	while [ -z $reponse ] || [ $reponse != 'oui' ]
	do
		read -p 'Dites oui : ' reponse
	done
	```

### 04.2 - Pour

a) Boucle simple

```bash
for i in `seq 1 10`; # Pour aller de 2 en 2 : seq 1 2 10
do
	echo $i
done
```

b) Boucle avec une liste

```bash
for fichier in `ls` 
do
    mv $fichier $fichier-old
done
```

## 05 - Fonctions

```bash
month="" # Pour renvoyer la variable

function get_month() {
    date_yyyymmdd=$1
    month=${date_yyyymmdd:4:2}
}

get_month 20210311
current_month=$month
```
