# Préparation de l'environnement de travail

TODO: Faire un TAG pour récupérer la bonne version.
TODO: Procédé de création du projet Gitlab.

Dans ce tutoriel, on va illustrer chaque explication avec un projet fictif. Pour cela, vous saurez que c'est à votre tour de jouer quand vous trouverez la balise suivante :

!!! example "A vous de jouer !"
    L'exercice

## 01 - Le projet Maven

Nous allons utiliser un projet Maven pour construire notre application. Et notre application va tout simplement retourner le message "Hello World !" dans le terminal (désolé je n'ai pas trouvé mieux... :eyes:).

!!! tip "Astuce"
    Vous pouvez très bien récupérer un projet maven à vous (ce sera plus palpitant ! :tada:).

Si jamais vous n'avez jamais fait de Java ou utilisé Maven, ce n'est pas grave, car on ne va pas s'intéresser réellement à ce code.

!!! info "Information"
    Sachez que les ingénieurs DevOps doit avoir une grande polyvalence car pour mettre en place tous les procédés et outils requis, il faut un minimum savoir comment fonctionne et commen est développé le projet (mais pas besoin de savoir comment le développeur va le faire :innocent:).

## 02 - Installation des technologies

Premièrement, nous allons installer Java :

```bash
sudo apt-get install openjdk-18-jdk
```

Et ensuite nous allons installer Maven :

```bash
sudo apt-get install maven
```

!!! tip "Astuce"
    Si vous utilisez Windows, tant pis pour vous ! :clown:

    Plus sérieusement, voici des liens pour vous aider :

    * [x] [Installation de Java](https://techoral.com/blog/java/download-openjdk-18.html) ;
    * [x] [Installation de Maven](https://maven.apache.org/install.html).

## 03 - Récupération du projet

Le projet est accessible sur mon super Gitlab :sunglasses:, ici :

[:material-book: Projet Simple Maven](https://gitlab.papierpain.fr/tutoriels/simple-maven/){ .md-button }

Bien que vous pouvez simplement télécharger le projet en zip, je vous conseille de faire un Fork/Copie vers un dépôt Gitlab ([Gitlab.com](https://gitlab.com/users/sign_in) ou autre) comme ça vous aurez exactement le même environnee de travail.

Enfin, vous pouvez clone le projet sur votre machine :

```bash
git clone ssh://git@gitlab.papierpain.fr:7137/tutoriels/simple-maven.git # Exemple de clone en SSH
```

## 04 - Tester le projet

Ensuite, dans le dossier du projet, exécutez les commandes suivantes pour lancer le projet :

```bash
mvn clean install # Compilation du projet
java -jar target/SimpleMaven-1.0.0-SNAPSHOT.jar # Lancement du projet
```

Si dans votre console cela affiche "Hello World !", c'est que le projet a fonctionné ! :tada:

Vous êtes donc prêt à commencer votre tutoriel !
