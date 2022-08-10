# Versionner son projet

!!! example "Documentation"
    Si vous souhaitez en apprendre plus sur les bases de Git avec un tutoriel (long mais détaillé), je vous conseille d'aller voir le lien suivant :

    [:material-book: Super tutoriel Git de l'Université de Lille](https://www.cristal.univ-lille.fr/TPGIT/){ .md-button }

Si vous avez bien suivi la première étape sur la préparation, vous pouvez vous rendre compte que votre projet est déjà versionné. Mais ici, nous allons voir comment respecter les règles de l'art pour avoir le plus beau des projets (oui... Même si c'est pour un simple "Hello Worls!" :eyes:).

## Rappel sur les phases de vie d'un projet

Lors du développement d'une application, il est important de savoir quelles sont les phases de vie d'un projet (cf. Fig. Workflow Git).

<figure markdown>
![Workflow Git](/images/versionner-son-projet/global-git.jpg){ width="100%" }
<figcaption>Workflow Git</figcaption>
</figure>

Il y a donc trois grandes phases :

* **:package: Phase de développement d'une version** : c'est ce qui se passe entre les branches de `features` et la branche `develop` ;
* **:rocket: Phase de pré-production** : c'est ce qui se passe avant la mise en production (donc on niveau de la branche de `release`) ;
* **:tada: Phase de mise en production** : c'est tout simplement la mise en production (donc entre la branche de `release` et la branche `master`).

!!! tip "Quatrième phase"
    En réalité, il peut y avoir [une quatrième phase](d-hotfix) : la phase de "on a tout cassé sur master", c'est-à-dire qu'il faut faire un fix sur la branche `master` pour que le projet soit fonctionnel.
    
    C'est ce qu'on appelle les `hotfix`.

    [Faire un hotfix (parce que j'ai tout cassé)](d-hotfix){ .md-button }

!!! info "Gestion des versions"
    Sur chaque phase, nous allons voir comment incrémenter la version mais pour avoir une vision d'ensemble et clair je vous conseille d'aller voir cette page :

    [Gestion des versions](e-versions){ .md-button }
