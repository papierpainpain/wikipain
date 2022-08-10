# Phase de mise en production (MEP)

Une fois la release faite et testée, on passe à la phase de mise en production. Ce qui correspond à la publication de la version (exemple : mise à jour du site web actuel).

C'est souvent le **Product Owner (P.O.)** qui se charge de cette phase (du moins pour les étapes **01** et **02**).

<figure markdown>
![Mise En Production](/images/versionner-son-projet/mep.jpg){ width="100%" }
<figcaption>Mise En Production</figcaption>
</figure>

Il y a quatres étapes pour la mise en production :

* 01 : La Merge Request de la branche de release sur la branche `master` ;
* 02 : Création du tag correspondant à la version de la branche de release ;
* 03 : Déploiement de la nouvelle version sur le serveur.

## 01 - Créer la Merge Request de la branche de release sur la branche `master`

Pour cette phase il vous suffit de vous référer à ces deux étapes de la phase de développement :

* [Faire sa Merge Request](../a-phase-developpement/#04-faire-sa-merge-request) ;
* [Vérifier une Merge Request](../a-phase-developpement/#05-verifier-une-merge-request).

!!! attention "Ne pas Squash"
    Vous ne devez pas faire un **Squash des commits** car on souhaite avant tout voir l'évolution de chaque ticket.
    De même pour la suppression de la branche de release, car à la fin on va merge la branche dans `develop`.

!!! example "A vous de jouer !"
    Créez la Merge Request de la branche de `1.0.0-release` sur la branche `master` :
    
    <figure markdown>
    ![Créer la Merge Request de la branche de release sur la branche `master`](/images/versionner-son-projet/creer-la-merge-request-de-la-branche-de-release-sur-la-branche-master.png){ width="100%" }
    <figcaption>Créer la Merge Request de la branche de release sur la branche `master`</figcaption>
    </figure>

    Enfin, vous pouvez vérifier la Merge Request et une fois fini, il vous faut cliquer sur le bouton **Merge**.

## 02 - Créer le tag correspondant à la version de la branche de release

Dans Gitlab, rendez-vous sur la branche `master`. Cliquez sur le :material-plus-circle: puis `New tag` (cf. Fig. Créer un tag).

<figure markdown>
![Créer un tag](/images/versionner-son-projet/start-create-tag.png){ width="100%" }
<figcaption>Créer un tag</figcaption>
</figure>

Ensuite, il vous reste à remplir les champs suivants (cf. Fig. Remplir les champs d'un tag) :

* **Tag name** : Votre numéro de version (exemple : `2.0.0`) ;
* **Create from** : `master` ;
* **Message** : Ce que vous voulez ;
* **Release notes** : Vous pouvez remettre la release note de votre fichier `README.md` pour la votre version.

<figure markdown>
![Remplir les champs d'un tag](/images/versionner-son-projet/fields-create-tag.png){ width="100%" }
<figcaption>Remplir les champs d'un tag</figcaption>
</figure>

!!! example "A vous de jouer !"
    A vous de faire la même chose, mais avec les valeurs suivantes :

    * **Tag name** : `v1.0.0` ;
    * **Create from** : `master` ;
    * **Message** : `` ;
    * **Release notes** : 

        ```md
        # Version 1.0.0

        Début de la release : 13.08.2022

        | Type  | Ticket | Sujet                            |
        | ----- | ------ | -------------------------------- |
        | Story | PAP-81 | Remplacer Hello World par Coucou |
        | Story | PAP-80 | Création d'un projet Java Maven  |
        ```

## 03 - Déploiement de la nouvelle version sur le serveur

Cette partie est vraiment propre à chaque projet, car elle dépend par exemple du langage utilisé, du type de serveur, etc.

!!! note "Exemple"
    Si vous utilisez **React**, vous devez build le projet, puis le déployer sur le serveur, en configurant, par exemple, **NGinx** pour l'exécution.

En revenche, on verra comment automatiser cette partie dans les sections Gitlab CI et Ansible.

!!! example "A vous de jouer !"
    Pour notre tutoriel, on peut imaginer que l'objectif et de générer l'exécutable (ici, le fichier `SimpleMaven-1.0.0.jar`) et le déployer sur un serveur de fichier pou le rendre disponible au public.

    Comme nous n'avons pas d'automatisation (pour l'instant), nous devons tout faire à la mains.

    * Récupérer la version du projet avec le tag `v1.0.0` :

        ```bash
        git fetch --tags
        git checkout v1.0.0
        ```
    
    * Compiler le projet :
    
        ```bash
        mvn clean package
        ```
    
    * Déployer le projet où vous voulez :

        Récupérer le fichier `target/SimpleMaven-1.0.0.jar` et mettez-le sur un Google Drive (oui je sais l'exemple n'est pas incroyable, mais c'est simplement pour expliquer le processus de déploiement).

## 04 - Mettre à jour `develop` avec la branche de release

Comme nous avons apporté des modifications à la branche de release, il faut mettre à jour la branche `develop` avec une Merge Request.

