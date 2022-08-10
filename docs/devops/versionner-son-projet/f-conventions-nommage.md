# Conventions de nommage

Ici on va récapituler les conventions de nommage utilisées dans le projet.

## 01 - Le nom des branches

Le nom de la branche doit au moins contenir le numéro du ticket, ici `ENGL-1900`.
    
Toute fois, il peut être pratique d'ajouter le nom du ticket pour simplifier la lisibilité : `ENGL-1900-creation-dune-fusee`.

!!! warning "Exeption"
    La branche de release doit avoir le nom suivant `X.X.X-release`, car elle n'est pas liée à un ticket.

## 02 - Les Merge Requests

Le titre des **Merge Requests** doit contenir le numéro du ticket et son titre. Le format est bien sûr à décider en amont, par exemple :

* `ENGL-1900 Création d'une fusée` ;
* `[ENGL-1900] Création d'une fusée` ;
* `:sparkles: ENGL-1900 Création d'une fusée`.

!!! tip "Les Gitmojis"
    Les GitMojis sont des emoji qui sont utilisés dans les commits.
    Ils sont utilisés pour signaler le statut d'un commit ou son type.
    Vous pouvez trouver tous les GitMojis sur **gitmoji.dev** :
    
    [Gitmoji](https://gitmoji.dev/){ .md-button }
    
    Dans certains projets, il est pratique de mettre des GitMojis dans le titre des Merge Requests afin de faciliter la lecture.
    Voici quelques exemples d'utilisation :

    * `:sparkles: ENGL-1900 Création d'une fusée` : Ajout d'une nouvelle fonctionnalité
    * `:bug: ENGL-1560 Correction du réacteur` : Correction d'un bug
    * `:construction_worker: ENGL-1911 Build de la fusée` : Ajout ou modification du CICD

    Ensuite, vous avez un projet Git tout jolie (cf. Fig. Projet Git avec Gitmojis) :

    <figure markdown>
    ![Projet Git avec Gitmojis](/images/versionner-son-projet/projet-git-avec-gitmojis.png){ width="100%" }
    <figcaption>Projet Git avec Gitmojis</figcaption>
    </figure>

## 03 - Les commits

Pour les commits, c'est sensiblement la même chose que pour les Merge Requests, mais en général, comme ils sont squashés, on est plus laxistes.
Voici quand même quelques conseils :

* Le commit doit être explicit ;
* Il peut contenir le numéro du ticket.
