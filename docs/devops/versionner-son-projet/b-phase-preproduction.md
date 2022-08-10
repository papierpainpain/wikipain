# Phase de pré-production

Une fois tous les tickets du sprint en cours traités, vous pouvez passer à la phase de pré-production.

Les étapes de cette phase sont plutôt simples, mais elles sont très importantes pour que votre projet soit bien préparé pour la phase de production.

<figure markdown>
![Création d'une release](/images/versionner-son-projet/release.jpg){ width="100%" }
<figcaption>Création d'une release</figcaption>
</figure>

## 02 - Créer la branche de release

En pré-production, on effectue nos tests sur une branche qui est créée à partir de la branche `develop`, cette branche est appelée **release** est la branche à le pattern suivant : **X.X.X-release** ou **release-X.X.X**.

Voici les étapes à suivre pour la création de cette branche :

### 02.1 - Créer la branche de release

Créer la branche de release à partir de la branche `develop`, avec le pattern `X.X.X-release`.

!!! example "A vous de jouer !"
    Retournez sur la branche `develop` et créez la branche de release.

    ```bash
    git checkout develop
    git pull origin develop
    git checkout -b 1.0.0-release
    ```

### 02.2 - Modifier la version de la branche de release

Sur la branche de release, vous devez changer le nom de version en remplaçant `X.X.X-SNAPSHOT` par `X.X.X` (dans les fichiers du projet contenant la version).

!!! example "A vous de jouer !"
    Modifiez la version dans le fichier `pom.xml`, au niveau de la balise `<version></version>` :
    
    ```xml
    <version>1.0.0</version>
    ```

    Puis sauvegardez les modifications :

    ```bash
    git add pom.xml
    git commit -m ":bookmark: release v1.0.0: Changement de la version en 1.0.0"
    git push origin 1.0.0-release
    ```

### 02.3 - Release note

Mettre à jour le README.md de la branche `develop` pour ajouter la **release note**.

La release note est une description de la version que l'on traite ici, et elle contient tous les tickets qui ont été traités.

```md
## Release note

### Version 1.3.0

* Début du sprint : 12.08.2022
* Fin du sprint : 13.08.2022
* Début de la release : 14.08.2022

| Type  | Ticket    | Sujet                 |
| ----- | --------- | --------------------- |
| Story | ENGL-1243 | Créer une super fusée |
```

!!! example "A vous de jouer !"
    Comme j'ai oublié de créer un fichier README.md, on va le créer et ajouter directement la release note dans le fichier.
    
    ```md title="README.md"
    # Sample Maven

    ## Description

    Simple projet Java en Maven.

    ## Release note

    ### Version 1.0.0

    Début de la release : 13.08.2022

    | Type  | Ticket | Sujet                            |
    | ----- | ------ | -------------------------------- |
    | Story | PAP-81 | Remplacer Hello World par Coucou |
    | Story | PAP-80 | Création d'un projet Java Maven  |
    ```

    Ici on garde seulement `Début de la release` car on ne fait pas de sprint. De plus, j'ai rajouté le ticket `PAP-80` que j'avais créé pour la création du projet (vous n'êtes pas obligé de le mettre).

    Enfin, on sauvegarde les modifications :
    
    ```bash
    git add README.md
    git commit -m ":bookmark: release v1.0.0: Ajout de la release note"
    git push origin 1.0.0-release
    ```

## 03 - Tests, tests, tests

Une fois la branche de release créée, vous pouvez commencer à vérifier votre projet sur cette branche, c'est-à-dire :

* Vérifier que tous les tickets ont été traités (même si ça aurait dû être fait dans la branche `develop`) ;
* Vérifier que l'existant fonctionne toujours (tests de non-régression) ;
* Re-tester les nouvelles fonctionnalités.

!!! hint "Procédé et rôles"
    Ce procédé peut durer plusieurs jours, ce qui permet d'avoir assez de recul pour tester votre version.

    Cette étape est d'ailleurs (suivant les équipes), faite par des responsables autres que les développeurs (exemple : Product Owner, Scrum Master, etc.), car ce sont eux qui ont la vision d'ensemble permettant de savoir ce qu'attend le client.

!!! tips "La prochaine version"
    Bien évidemment, les développeurs doivent se pencher sur les tickets concernant la version suivante (celle de la branche `develop`).

## 04 - Correction des bugs

Bon, si les développeurs n'ont pas bien travaillé (ou qu'il manque des éléments), il faut corriger leurs bêtises. Pour cela, c'est comme en développement, vous créez un ticket concernant le bug, vous le traitez, et vous le reportez sur la branche de release (Merge Request).

<figure markdown>
![Correction d'un bugs avec Chery-pick](/images/versionner-son-projet/chery-pick-correction.jpg){ width="100%" }
<figcaption>Correction d'un bugs avec Chery-pick</figcaption>
</figure>

!!! warning "Attention"
    Comme vous avez fait une modification sur la branche de release, vous devez aussi reporter la modification sur la branche `develop`, en faisant un Cherry-Pick.

    <figure markdown>
    ![Bouton de validation de la Merge Request](/images/versionner-son-projet/merged-btn-mr.png){ width="100%" }
    <figcaption>Bouton de validation de la Merge Request</figcaption>
    </figure>

    Pour cela, après avoir mergé la branche (cf. Fig. Bouton de validation de la Merge Request), vous devez cliquer sur Cherry-Pick (cf. Fig. Choix du Cherry-Pick).

    <figure markdown>
    ![Choix du Chery-Pick](/images/versionner-son-projet/choose-chery-pick.png){ width="100%" }
    <figcaption>Choix du Chery-Pick</figcaption>
    </figure>

    Puis choisir la branche `develop` pour la nouvelle Merge Request (cf. Fig. Choix de la branche de destination du Cherry-Pick).

    <figure markdown>
    ![Choix de la branche de destination du Chery-Pick](/images/versionner-son-projet/chery-pick.png){ width="100%" }
    <figcaption>Choix de la branche de destination du Chery-Pick</figcaption>
    </figure>

## 05 - Fini

Votre version est prête à être livrée !
