# Phase de développement d'une version

Si vous êtes familié avec la méthode Agile, vous savez que l'on fonctionne par sprints (itérations). Chaque sprint mène, en général, à une nouvelle version et dans chaque version on développe des fonctionnalités, appelées ici **features**. Ces fonctionnalités sont listées dans Jira sous forme de ticket.

Les **features** sont des branches qui sont créées à partir de la branche `develop` (cf. Fig. Création d'une feature).

<figure markdown>
![Création d'une feature](/images/versionner-son-projet/dev-feature.jpg){ width="100%" }
<figcaption>Création d'une feature</figcaption>
</figure>

!!! note "Version de développement"
    La version de développement aura toujours le pattern **X.X.X-SNAPSHOT**, même sur les branches de **features**. Par ailleurs, la version **X.X.X** correspond à la version de la future version.

## 01 - Créer sa feature

Premièrement, vous devez prendre un ticket dans le Sprint en cours sur [le Jira](https://papierpain.atlassian.net/jira/your-work).

Ensuite vous créez la branche `<numero-du-ticket>`. Il faut que la branche soit créée à partir de la branche `develop` (cf. Fig. Création d'une feature).

```bash
git checkout develop # On se place sur la branche develop
git pull origin develop # On récupère les changements de la branche develop
git checkout -b <numero-du-ticket> # On crée la branche
```

!!! example "A vous de jouer !"
    Maintenant que vous avez votre projet Maven en place sur Gitlab, vous verrez deux branches : `master` et `develop`.

    Placez vous sur la branche `develop` et récupérez les mises-à-jour du dépôt distant :

    ```bash
    git checkout develop
    git pull origin develop
    ```

    Vous pouvez maintenant créer votre ticket sur Jira :

    <figure markdown>
    ![Créer un ticket Jira](/images/versionner-son-projet/jira-create-ticket.png){ width="100%" }
    <figcaption>Créer un ticket Jira</figcaption>
    </figure>

    Ici, on va modifier le "Hello World!" pour afficher "Coucou !", donc nous expliquons ce que l'on va faire dans le ticket :

    <figure markdown>
    ![Description de la nouvell fonctionnalité (Jira)](/images/versionner-son-projet/jira-new-ticket.png){ width="100%" }
    <figcaption>Description de la nouvell fonctionnalité (Jira)</figcaption>
    </figure>

    !!! info "Type de ticket"
        Il existe plusieurs types de tickets : `bug`, `story` et `task`. Comme nous développons une nouvelle fonctionnalité, nous voulons créer un ticket de type `story`.
    
    Ensuite, de retour sur la branche `develop`, nous allons créer notre nouvelle branche avec le numéro de ticket et le titre de la `story` :

    ```bash
    git checkout -b PAP-81-remplacer-hello-world-par-coucou
    ```

    A ce moment-là, vous pouvez changer le status de votre ticket Jira à `In Progress` (ou `En cours`).

!!! hint "Convention de nommage des branches"
    Le nom de la branche doit au moins contenir le numéro du ticket, ici `ENGL-1900`.

    Toute fois, il peut être pratique d'ajouter le nom du ticket pour simplifier la lisibilité : `ENGL-1900-creation-dune-fusee`.

    Plus d'informations ici :
    
    [Les conventions de nommage](../f-conventions-nommage/){ .md-button }

## 02 - Développer la feature

Dans cette étape, vous avez juste à réaliser la tâche de votre ticket.

Quelques conseils tout de même :

* Votre code doit être lisible et compréhensible ;
* Mettre de la documentation (:pleading_face: s'il vous plaît...) ;
* Tester votre code ;
* Faire des commits réguliers pour retrouver plus rapidement les bugs ou éléments qui vous intéressent au cours du développement.

Pour faire un commit, il faut :

```bash
git add mon_fichier # On ajoute les modifications à la branche
git commit -m "message décrivant ce que vous avez fait"
git push origin <nom-de-la-feature> # Mise à jour de la branche distante
```

!!! example "A vous de jouer !"
    Maintenant, ouvrez le fichier `src/main/java/fr/papierpain/Main.java` puis modifiez le code pour qu'il affiche "Coucou !" :

    ```java title="Ligne 4 du fichier Main.java"
    private final String message = "Coucou !";
    ```

    Ensuite, faites un commit et push :
    
    ```bash
    git add src/main/java/fr/papierpain/Main.java
    git commit -m ":sparkles: PAP-81 : Ajout du message 'Coucou'"
    git push origin PAP-81-remplacer-hello-world-par-coucou
    ```

## 03 - Synchroniser sa feature avec develop

En parallèle de votre développement, je vous conseille de synchroniser régulièrement votre branche avec la branche `develop` car vous n'êtes pas tout seul sur le projet ! Si vous ne voulez pas traiter 10 000 conflits, c'est un bon réflexe à avoir.

### 03.1 - Sauvegarder mes modifications

Pour cela, vous devez sauvegarder vos modifications sur votre branche distante comme avec le point **02**, c'est-à-dire :

```bash
git add mon_fichier # On ajoute les modifications à la branche
git commit -m "message décrivant ce que vous avez fait"
git push origin <nom-de-la-feature> # Mise à jour de la branche distante
```

### 03.2 - Récupérer les modifications de la branche `develop`

Ensuite, vous devez récupérer les mises à jour de la branche `develop` :

```bash
git checkout develop # On se place sur la branche develop
git pull origin develop # On récupère les mises à jour de la branche distante
```

### 03.3 - Synchroniser sa branche avec la branche `develop`

Et enfin, on fait un merge entre la branche `develop` et la branche `<nom-de-la-feature>` :

```bash
git rebase -i develop <nom-de-la-feature>
```

### 03.4 - J'ai des conflits

Si vous avez des conflits, il faut les résoudre (de rien ! :heart:).

Lorsque vous avez des conflits, ils sont listés dans le terminal avec la liste des fichiers. Donc, dans votre IDE, vous aurez le pattern suivant au niveau des conflits :

```txt
<<<<<<< HEAD
Les modifications que vous avez apportées.
=======
Les modifications de la branche develop.
>>>>>>> develop
```

Ensuite, il faut régler les conflits :

* Choisir ce que vous gardez ;
* Enregistrer les modifications :
  
    ```bash
    git add mon_fichier
    ```

* Poursuivre le rebase avec :
  
    ```bash
    git rebase --continue
    ```

Enfin, pour terminer le rebase, il faut sauvegarder les modifications sur votre branche distante :

```bash
git push origin <nom-de-la-feature>
```

!!! warning "Attention"
    Si après un rebasage il dit "Ooouais c'est quoi ça gneugneugneu !?", faites la commande suivante qui permet de forcer les changements :

    ```bash
    git push --force origin <nom-de-la-feature>
    ```

## 04 - Faire sa Merge Request

Le but est de faire vérifier son code par quelqu'un d'autre avant d'envoyer ses modifications sur develop.

Pour faire une merge request avec l'interface graphique :

* [x] Ouvrez votre projet gitlab
* [x] Choisissez `Merge requests` dans le menu latéral gauche
* [x] Choississez votre branche (ici develop) et la branche de destination (ici master) :

    <figure markdown>
    ![Merge request branchs](/images/versionner-son-projet/merge_request_form.png){ width="100%" }
    <figcaption>Formulaire de choix des branches</figcaption>
    </figure>

* [x] Puis, remplissez le formulaire suivant :

    <figure markdown>
    ![Merge request form](/images/versionner-son-projet/merge_request_form_config.png){ width="100%" }
    <figcaption>Formulaire de demande de merge rempli</figcaption>
    </figure>

    N'oubliez pas de remplir les champs suivants :

  * `title` : C'est le numéro de votre ticket suivi de son sujet (ex. `ENGL-1900 - Créer une fusée`) ;
  * `description` : une description de ce que vous avez fait ;
  * `assignee` : l'utilisateur qui va traiter votre merge request ;
  * Merge option : `delete source branch` : pour supprimer la branche source après avoir fait le merge ;
  * Merge option : `squash` : fusionner tous les commits (c'est plus propre).

!!! example "A vous de jouer !"
    Retournez sur Gitlab et créez une Merge Request comme au dessus avec les informations suivantes : 

    <figure markdown>
    ![Choisir sa branche PAP-81 et develop](/images/versionner-son-projet/tuto-create-mr.png){ width="100%" }
    <figcaption>Choisir sa branche PAP-81 et develop</figcaption>
    </figure>

    <figure markdown>
    ![Remplir les champs avec les informations du ticket Jira](/images/versionner-son-projet/tuto-mr-fields.png){ width="100%" }
    <figcaption>Remplir les champs avec les informations du ticket Jira</figcaption>
    </figure>

    !!! info "N'oubliez pas de changer le statut de votre ticket Jira à `In Review` et de l'assigner à la personne qui va vérifier votre ticket !"

## 05 - Vérifier une Merge Request

Pour vérifier une merge request, il faut :

* [x] Vérifier la branche de destination (ex. : `develop` mais **SURTOUT** pas `master`) ;
* [x] Tester le code (sur votre environnement local) ;
* [x] Vérifier si le code est correct (lisible, bonnes conventions, indentation, etc.) ;
* [x] Vérifier qu'il y ait bien de la documentation ;
* [x] Ensuite checker si il n'y a pas de conflits ;
* [x] Vérifier si la branche est à jour par rapport à la branche `develop` (voir la section **03**).

Une fois tous ça fait, vous pouvez valider la Merge Request !

!!! example "A vous de jouer !"
    Retournez sur Gitlab et validez la Merge Request en appuyant sur `Merge` une fois que vous avez vérifié toutes les étapes.

    Vous pouvez d'ailleurs voir les modifications dans l'onglet `Changes` de la Merge Request. 
    
    <figure markdown>
    ![Valider la Merge Request](/images/versionner-son-projet/tuto-validate-mr.png){ width="100%" }
    <figcaption>Valider la Merge Request</figcaption>
    </figure>

    !!! info "N'oubliez pas de changer le statut de votre ticket Jira à `Ready For Delivery` !"
