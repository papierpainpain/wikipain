# Introduction à Gitlab CI

!!! warning "En cours de rédaction..."

**Gitlab CI** permet d'automatiser des tâches et procédé au cours d'un projet. Pour cela, vous devez créer un fichier `.gitlab-ci.yml` à la source de votre projet **Gitlab**.

Par exemple, avec la configuration suivante, nous allons afficher un simple `Hello World!` sous un environnement alpine (par défaut sur l'instance `gitlab.papierpain.fr`).

```yaml title=".gitlab-ci.yml"
job-name:
    script:
        - echo "Hello World!"
```

!!! example "A vous de jouer !"
    Dans n'importe quel projet Gitlab, créez un fichier `.gitlab-ci.yml` à la source de votre projet, et ajoutez les lignes suivantes :

    ```yaml title=".gitlab-ci.yml"
    job-name:
        script:
            - echo "Hello World!"
    ```

    Ensuite, allez dans le menu de gauche dans `CI/CD > Pipelines`.

    <figure markdown>
    ![Onglet Pipelines](/images/gitlab-ci/menu-pipelines.png){ width="100%" }
    <figcaption>Onglet Pipelines</figcaption>
    </figure>

    Après avoir cliqué sur le button `Run pipeline` vous pourrez renseigner la branche sur laquelle vous pourrez exécuter votre configuration et ajouter des paramètres.

    <figure markdown>
    ![Parametrer un pipeline](/images/gitlab-ci/run-pipeline.png){ width="100%" }
    <figcaption>Parametrer un pipeline</figcaption>
    </figure>

    Une fois exécuté, vous vous trouvez sur une page listant tous les jobs (ici seulement un est présent).

    <figure markdown>
    ![Informations sur le pipeline exécuté](/images/gitlab-ci/running-pipeline-info.png){ width="100%" }
    <figcaption>Informations sur le pipeline exécuté</figcaption>
    </figure>

    Pour voir la console, il suffit de cliquer sur l'icon du job `job-name` et vous verrez plusieurs informations comme la préparation de l'environnement et l'exécution du script (ici `echo "Hello World!"`).

    <figure markdown>
    ![Console d'un job](/images/gitlab-ci/console-job.png){ width="100%" }
    <figcaption>Console d'un job</figcaption>
    </figure>

## 01 - Pipeline et stages

<figure markdown>
![Pipeline stages jobs](/images/gitlab-ci/pipelines-jobs.png){ width="100%" }
<figcaption>Pipeline stages jobs</figcaption>
</figure>

Un pipeline est un ensemble de tâche à réaliser lors d’un procédé (ex. : merge request, commit, etc.) et pouvant être en parallèle. Un pipeline est composé de stages que l'on peut comparer à des étapes. Chaque stage est composé de jobs qui sont les tâches à réaliser grâce à un script.

```yaml title="Structure d'un pipeline (.gitlab-ci.yml)"
build-site: # Nom du job
    stage: build # Définition du stage du job 'build-site'
    script: # Script contenant la liste des instructions bash
        - echo "Construction du site web..."

build-api:
    stage: build
    script:
        - echo "Construction des APIs..."

deploy:
    stage: deploy
    script:
        - echo "deploiement de l'application..."
```

!!! hint "Type de stage"
    Par défaut, il y a des stages prédifinis, ils sont les suivants (par ordre d'exécution) :

    1. **.pre**
    2. **build**
    3. **test** (par défaut si aucun stage n'est défini)
    4. **deploy**
    5. **.post**

    Bien évidemment, vous pouvez définir les votre mais je vous conseille tout de même d'utiliser ceux par défaut pour respecter les conventions imposé par Gitlab CI.

    [:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/yaml/#stages){ .md-button }

## 02 - Job

[:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/jobs/){ .md-button }

Comme vu plus haut, un job doit à minima contenir une clé `script` contenant comme valeur un tableau de ligne de commande.

```yaml title=".gitlab-ci.yml"
job-name:
    script:
        - echo "Hello"
        - echo "World"
        - echo "!"
```

!!! hint "Les lignes de commande"
    L'environnement par défaut est une image Alpine mais vous verrez par la suite que vous pouvez choisir lequel vous souhaitez donc il faut adapter les scripts à l'environnement d'exécution.

### 02.1 - Before script & after script

[:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/yaml/script.html#set-a-default-before_script-or-after_script-for-all-jobs){ .md-button }

Ces deux clés permettent d'ajouter des pré-scripts et des post-scripts. Cela permet surtout d'améliorer la lisibilité.
En plus de cela, la clé `after_script` s'exécute toujours même s'il y a une erreur dans le `before_script` ou dans le `script`.

```yaml title=".gitlab-ci.yml"
test-before-after:
    before_script:
        - echo "Connecting..."
    script:
        - echo "Do something..."
    after_script:
        - echo "Clean workspace..."
```

### 02.2 - Artifacts

[:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html){ .md-button }

Cela permet d'avoir une archive contenant des fichiers ou des dossiers, générée dans le job. Grâce à cela, on peut soit la télécharger à la main soit la transmettre à un autre job.

```yaml title=".gitlab-ci.yml"
generate-file:
    stage: build
    script:
        - echo "Hello World!" >> test.txt
    artifacts:
        paths:
            - test.txt
        expire_in: 1 week

print-file:
    stage: test
    script:
        - cat test.txt
    needs:
        - job: generate-file
          artifacts: true
```

### 02.3 - Dépendances (needs)

[:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/yaml/#needs){ .md-button }

Cela permet de modifier l’ordre d’exécution. Les dépendances sont liées aux jobs et non pas aux stages.

<figure markdown>
![Schéma des dépendances](/images/gitlab-ci/dependances-schema.png){ width="100%" }
<figcaption>Schéma des dépendances</figcaption>
</figure>

```yaml title=".gitlab-ci.yml"
build-site:
    stage: build
    script:
        - echo "Site..."
build-api:
    stage: build
    script:
        - echo "API..."
build-wiki:
    stage: build
    script:
        - echo "Wiki..."

deploy-app:
    stage: deploy
    script:
        - echo "Deploy app..."
    needs:
        - build-site
        - build-api
deploy-wiki:
    stage: deploy
    script:
        - echo "Publish wiki..."
    needs:
        - build-wiki
```

## 03 - Variables

[:material-book: Documentation officielle](https://docs.gitlab.com/ee/ci/variables/){ .md-button }

Je ne vais pas vous expliquer ce qu'est des variables (vous êtes normalement censés savoir ce que c'est...) mais voici les quatres types de variables dans **Gitlab CI** :

- **Variables prédéfini** (`CI_COMMIT_BRANCH`, `CI_PROJECT_NAME`, etc.) : Variables proposées par défaut par Gitlab CI ;
- **Variables de groupes/projets** : Définies par vous même soit globales aux projets d'un groupe ou spécifiques à un groupe (vous avez besoin d'être maintainer pour le faire) ;
- **Variables globales** (de pipeline) : Définies dans le fichier `.gitlab-ci.yml`. C'est d'ailleurs elles qui permettent de configurer les paramètres ;
- **Variables de job** : Définies sur chaque job.

```yaml title="Fonctionnement des variables (.gitlab-ci.yml)"
job-name:
    script:
        - echo "$VAR_TEST"
        - 'echo "Nom du projet : $CI_PROJECT_NAME"'
```

<figure markdown>
![Résultat du test des variables](/images/gitlab-ci/resultat-test-variables.png){ width="100%" }
<figcaption>Résultat du test des variables</figcaption>
</figure>

## 04 - Conditions

Il y a plein de type de conditions et de configurations mais nous allons voir celle qui sont souvent utilisés :

- **worflow** : Configuration globale à tout le pipeline ;

    Dans l'exemple ci-dessous, on souhaite que la pipeline ne soit exécutable seulement lorsque l'on utilise l'interface web.
    
    ```yaml title=".gitlab-ci.yml"
    workflow:
        rules:
          - if: $CI_PIPELINE_SOURCE == 'web'
            when: always
          - when: never
    ```

- **only** & **except** : Configuration sur les jobs.

    Dans l'exemple ci-dessous, le job sera lancé seulement si on est sur la branche précisée.
    
    ```yaml title=".gitlab-ci.yml"
    job-name:
        script:
          - echo "Hello World!"
        only:
          - my-branch
    ```

## 05 - Runners

[:material-book: Documentation officielle](https://docs.gitlab.com/runner/){ .md-button }

Les runners se sont des éléments clés pour pouvoir exécuter vos jobs car sans eux rien ne marche :smiley: ! En fait, ce sont des agents exécutant les scripts des jobs de votre pipeline avec un environnement donné.

!!! info "Sur PapierPain Corp. :clown:"
    Dans l'intance actuelle ([gitlab.papierpain.fr](https://gitlab.papierpain.fr)), le runner par défaut c'est une image docker Alpine. Bien évidemment ce n'est pas du tout imposé, vous pouvez très bien généré votre image docker avec ce que vous voulez (:warning: *faites attention à l'architecture du processeur pour la construction*).

Ici on va voir deux types de runners, tels que :

- **Shell** : Qui exécute les scripts directement sur le serveur où se trouve le runner.

    ```yaml title=".gitlab-ci.yml"
    job-name:
        tag:
            - shell # tag permettant de choisir le runner shell
    ```

- **Docker** : Qui crée un container docker où sera exécutées les commandes.

    ```yaml title=".gitlab-ci.yml"
    job-name:
        image: arm32v7/node:17.9-alpine # Comme le runner docker est par défaut, on a juste à préciser l'image que l'on souhaite
    ```

## 06 - Structure

Pour ce qui est des fonctionnalités, globalement vous pouvez les retrouver sur la documentation officielle mais le problème est qu'il n'y a pas grand chose sur la structuration de vos pipeline. En effet, vous pouvez vous retrouver avec un seul fichier contenant les jobs pour les merge requests, les mises en production, etc. Donc ça devait très sale rapidemment.

Pour y remédier, voici quelques astuces à mettre en place.

### 06.1 - Configuration par défaut

Ici on a un élément `default` qui servira de base pour tous les jobs.

```yaml title=".gitlab-ci.yml"
default:
    tags:
        - shell

job-name:
    script:
        - echo "Hello!"
```

### 06.2 - Template de job

L'inconvénient de l'élément `default` est qu'il s'exécute sur tous les jobs mais si vous souhaitez définir une configuration commune à certain jobs, il faudra utiliser les Templates.

```yaml title=".gitlab-ci.yml"
.shell-template:
    tags:
        - shell

job-name:
    extends: .shell-template
    script:
        - echo "Hello!"
```

### 06.3 - Scripts

Si vous avez un script assez important, je vous conseille **FORTEMENT** de faire une fonction dans un fichier à part. Voici un fichier type que vous pouvez créer (avec les commentaires c'est top !).

```bash title="ci/scripts/my_function.sh"
#!/bin/sh
set -x
 
#! USAGE:
#!   path/to/script.sh <param-01> <param-02>
#! MAIN:
#!   Description of the function
 
function_name()
{
    VAR_01=$1
    VAR_02=$2
    VAR_03="value"
 
    # Do something
}
 
function_name $1 $2
```

```yaml title=".gitlab-ci.yml"
job-name:
    script:
        - ./ci/scripts/my_function.sh param01 param02
```

### 06.4 - Externalisation des fichiers Gitlab CI

Enfin, vous pouvez aussi avoir des fichiers de configuration avec le pattern `amazing-file.gitlab-ci.yml` que vous appelez dans votre fichier principal `.gitlab-ci.yml`.

Par exemple :

```yaml title="ci/jobs/amazing-file.gitlab-ci.yml"
job-name:
    script:
        - ./ci/scripts/my_function.sh param01 param02
```

```yaml title=".gitlab-ci.yml"
include:
    - local: ci/jobs/amazing-file.gitlab-ci.yml
```

!!! tip "Arborescence du CI/CD"
    Comme vous avez pu le voir, je ne mets pas les fichiers à la racine car le but est d'avoir quelque chose de clair sachant que le CI/CD ne doit pas conplexifier l'arborescence de base du projet. C'est pour ça que l'on met toute la configuration dans un dossier `ci`.

    ```log title="Arborescence"
    ci
    ├── jobs
    │   └── amazing-file.gitlab-ci.yml
    └── scripts
        └── my_function.sh
    .gitlab-ci.yml
    ```
