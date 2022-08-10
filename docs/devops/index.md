# DevOps

!!! info "Petite note"
    Ce tutoriel a avant tout pour but de présenter l'univers **DevOps** à travers mon expérience. Donc il est possible que certains points soient manquants ou soient incomplets.

    Par ailleurs, n'hésitez pas à me contacter pour toute suggestion ou demande d'ajout ([via le formulaire de contact](https://www.gourves-steven.fr/contact-me)).

## 01 - Contexte

Avant de commencer, avec **DevOps**, il faut savoir que dans un projet de Génie Logiciel (ex. : création d'une application, refonte d'un logiciel, etc.), il existe de nombreux rôles tous aussi important que les autres (list non exhaustive) :

* [x] Les testeurs ;
* [x] Les développeurs ;
* [x] Le Product Owner : personne faisant le lien entre le projet et le client ;
* [x] Les opérateurs : responsables de la mise en place et de la maintenance de l'environnement du projet (ex. : réseaux, serveurs, systèmes d'exploitation, etc.).
* [ ] Et bien d'autres.

Bien sûr ces rôles ou plutôt ces équipes ont chacunes des contraintes et malgrès ça, elles doivent travailler ensemble en prenant en compte toutes les contraites (et ce n'est pas facile :cry:).

C'est pourquoi il faut avant tout **organiser** l'environnement de travail, notamment avec des méthodes Agiles de gestion de projet (SCRUM, Kanban, etc.). En général, ce n'est pas suffisant, car l'objectif c'est d'optimiser le temps et d'améliorer la qualité de travail, et pour y remedier, il existe maintenant l'approche **DevOps**.

Comme [Atlassian l'a très bien fait](https://www.atlassian.com/fr/devops), voici leur super définition sur le sujet :

!!! quote ""
    DevOps est un ensemble de pratiques et d'outils, ainsi qu'une philosophie culturelle. Son but est d'automatiser et d'intégrer les processus entre les équipes de développement et informatiques.

Donc DevOps permet, avant tout, de simplifier et de clarifier les procédés (développement, communication, etc.) utilisés dans le cadre d'un projet. En pratique, c'est une équipe DevOps à part entière qui s'occupe de ces tâches (ou une personne suivant l'ampleur du projet).

## 02 - Le cycle de vie DevOps

Voici, donc un beau schéma sur le cycle de vie **DevOps** :

<figure markdown>
![Cycle de vie DevOps](https://velog.velcdn.com/images/doradora/post/74e1775b-680a-419b-927f-98e2eda05505/cicd.png){ width="100%" }
<figcaption>Cycle de vie DevOps (cf. https://velog.io/@doradora/CICD)</figcaption>
</figure>

D'une part on a le développement en continue (CI) où, par itération, on va organiser, développer une fonctionnalité, construire une version de test, la tester puis la valider pour le prochain déploiement.

D'autre part, on a le déploiement (CD) où, par itération, on va déployer la version, maintenir les plateformes et mettre en place des outils de supervision.

!!! tldr "CI/CD"
    C'est l'automatisation des tâches de chaque étape du cycle de vie **DevOps**. On peut ainsi diviser en deux étapes :

    * **CI** (*Continuous Integration*) : automatisation de la construction et des tests sur l'application ;
    * **CD** (*Continuous Delivery and Deployment*) : automatisation de la mise en place et de la supervision des environnements.

## 03 - Les outils

Ici, je ne vais vous présenter que les pratiques et les outils qui sont les plus utilisés (ou plutôt que j'utilise au quotidien).

* [x] **Gitlab** : pour versionner et gérer son projet ;
* [x] **Gitlab CI** : pour automatiser les tâches lors du développement et du déploiement (ex. : tests, déploiement, etc.) ;
* [x] **Ansible** : pour automatiser la configuration des plateformes et le déploiement des outils et du projet.

En plus de ces outils, nous utiliserons Jira pour gérer les tickets, ce n'est pas un outil propre à DevOps, mais il est très utile dans le cadre d'un projet en méthode Agile.

!!! example "Documentation"
    Si vous souhaitez en savoir plus sur la méthode Agile (ici Scrum), vous pouvez consulter la documentation suivante sur la méthode :

    [Scrum documentation](https://blog.trello.com/fr/methode-agile-scrum-gestion-projet){ .md-button }
