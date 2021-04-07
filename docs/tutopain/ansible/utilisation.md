# Comment utiliser Ansible

## Description

Mise en place des environnements de developpement, de test (preproduction) et de déploiement.

## Utilisation d'un Playbook

Pour exécuter un Playbook vous devez vous rendre sur l'interface web dans le menu `CI/CD` puis `pipelines` du projet ansible.

Ensuite lors que vous faites `Run pipeline`, vous devez renseigner les informations suivantes :

* PLAYBOOK_NAME : c'est le nom du Playbook que vous voulez exécuter et qui se trouve à la racine du projet ;
* ENVIROMENT : Vous avez le choix entre prod (pour une mise en production) ou dev pour tout le reste ;
* VARIABLES : Si votre Playbook a besoin de variables vous devez les renseigner de la forme suivante `var_01=value var_02=value`.

## Développement

### Création d'un playbook

Votre playbook doit OBLIGATOIREMENT être à la racine du projet avec la forme suivante `nom_de_playbook.yml` :

```yml
# Description du playbook pour savoir ce qu'il fait.
# Variables :
#   - var_01 : variable 01 description
#   - var_02 : variable 02 description

- hosts: host_name # Il est defini dans votre environnement (inventories) dans le fichier hosts
  become: true # Si vous avez besoin de tous les privilèges vous pouvez mettre cette ligne
  gather_facts: false # Les gather_facts récupèrent des informations sur l'host (souvent pas utilisées) donc on les désactive

  roles: # Liste des rôles que vous voulez utiliser
    - role: role_name
      vars: # Pour ajouter des variables à votre rôle
        - role_name_var_01: value
        - role_name_var_02: value

  pre_tasks: # Taches que l'on exécute AVANT l'étape 'tasks'
    - name: task description
      task_name:
        parametre_01: "{{ test }}" # Pour le paramètre on veut lui faire passer la variable 'test'
        parametre_01: present

  tasks:
    - name: task description
      task_name:
        parametre_01: "{{ test }}" # Pour le paramètre on veut lui faire passer la variable 'test'
        parametre_01: present
      register: task_register # Cela permet le débuggage en récupérant la sortie de la tâche (erreurs, informations...)
    
    # Le debug permet d'afficher dans la description du job les informations relatives au 'task_register'
    - name: output task_register
      debug:
        msg: "{{ task_register }}"
```

### Création d'un rôle

Pour créer un rôle je vous conseille FORTEMENT d'utiliser la commande suivante (surtout que vous gagnez du temps xD).
Mettez vous dans le dossier `roles` puis :

```bash
ansible-galaxy init votre_role
```

!!! Tips "Astuce"
    Sur votre linux local (ou wsl car windows>linux) vous avec juste à installer ansible pour exécuter la commande (ex. : `sudo apt install ansible`)

Ensuite vous devez avoir la structure suivante (ou qui y ressemble) :

```md
.
├── README.md
└── roles
    └── postgres
        ├── README.md # La documentation de votre rôle
        ├── defaults # Les variables par défaut
        │   └── main.yml
        ├── handlers # Je sais pas donc si vous ne l'utilisez supprimez le
        │   └── main.yml
        ├── meta # Informations sur votre rôle (c'est utile pour l'export de rôle je crois)
        │   └── main.yml
        ├── tasks # C'est ici que toutes les tâches que votre rôle fait doit être écrites
        │   └── main.yml
        ├── tests # Tests pour vérifier que votre rôle fonctionne
        │   ├── inventory
        │   └── test.yml
        └── vars # Définition des variables globales à votre rôle
            └── main.yml
```

#### Defaults et Vars

Dans ces dossiers seul le fichier main.yml sera pris en compte avec la structure suivante :

```yml
---

role_name_var_01: value
role_name_var_02: value
```

!!! Tips "Astuce"
    Par convention le nom des variables dans votre role doit être précéder du nom du rôle.


#### Tasks

Même chose, le main.yml sera le fichier que lira par défaut votre rôle donc si vous voulez avoir plusieurs fichiers pour un rôle propre (pitié faites le ! ❤️) voici la démarche à suivre :

```yml
---
# tasks file for role_name

- import_tasks: prerequisites.yml

- import_tasks: check_vars.yml

- import_tasks: install.yml
```

!!! Tips "Astuce"
    En générale c'est mieux d'avoir cette architecture avec prerequisites.yml, check_vars.yml et install.yml comme ça c'est plus lisible. D'ailleurs ces fichiers doivent être dans le dossier 'tasks'.


### Gestion des environnements

La gestion des environnements se passe dans le dossier `inventories` et ensuite vous avez le nom de l'environnement (ici soit `prod` soit `dev`).

Puis vous avez le fichier `hosts` pour définir vos machines ou groupe de machine de la façon suivante :

```yml
[host_01]
X.X.X.X
X.X.X.X

[host_02]
X.X.X.X
```

Si vous souhaitez définir des variables pour un host il faut créer un fichier dans `group_vars` avec les variables.
Par exemple, nous avons la structure suivante :

```md
.
└── group_vars
    ├── host_01 # fichier avec les variables
    └── host_02 # dossier contenant les variables (cachées et visibles)
        ├── vars # Variables visibles
        └── vault # fichier chiffré avec les variables cachées
```

#### Chiffrer des variables

Vous pouvez avoir besoin de cacher les valeurs de certaines variables et pour cela vous devez créer un dossier avec le nom de l'host comme au dessus avec le fichier vars contenant toutes vos variables.

Puis en ligne de commande :

```bash
ansible-vault create inventories/dev/group_vars/host_02/vault
```

Vous allez devoir rentrer un mot de passe (ici demandez moi quoi mettre car il faut avoir le même mdp pour chaque vault pour la pipeline).
Puis vous pouvez mettre vos variables comme pour un fichier classique mais précédé de `vault_` :

```yml
---
vault_var_01: value
vault_var_02: value
```

Puis dans votre fichier `vars` vous aurez :

```yml
---
var_01: "{{ vault_var_01 }}"
var_02: "{{ vault_var_02 }}"
var_03: value
```

Si vous devez modifier ou ajouter des valeurs, faites la commande suivante :

```bash
ansible-vault edit inventories/dev/group_vars/host_02/vault
```

### Conventions

* Le nom des variables, fichiers, roles... : en `snake_case` ;
* La documentation Ansible est vraiment bien donc utilisez là ! Surtout qu'il y a des exemples dans la doc.
