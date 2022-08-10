# Configuration d'Ansible avec Gitlab CI

Configuration effectuée sur une Raspberry pi avec Rasbian (debian).

???+ summary
    Ansible est un logiciel permettant la configuration et la gestion d’environnements ou de groupes d’environnements.
    Gitlab CI est un outil permettant de faire du CICD qui est l'automatisation des tâches réalisées dans votre développement (test) et le déploiement dde  votre code.

## 01 - Installation

???+ quote
    Cette installation est pour un environnement physique (ici directement sur la raspberry pi), mais je vous conseille de faire un container docker afin d'externaliser Anisble pour une gestion plus facile de votre environnement.

Mise à jour de votre environnement :

```bash title="Commande(s) bash" linenums="1"
sudo apt update
sudo apt -y upgrade
```

Installation des pré-requis à Ansible :

```bash title="Commande(s) bash" linenums="1"
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip
```

Installation d'Ansible :

```bash title="Commande(s) bash" linenums="1"
pip3 install ansible --user
```

## 02 - Configuration

### 02.1 - Configuration des environnements

La configuration des environnements à pour but de créer un couple de clés ssh pour pouvoir se connecter sur les environnements que vous souhaitez gérer. Nous allons également configurer un utilisateur `ansible` avec des droits sudo pour pouvoir gérer votre machine.

**Environnement du runner (gitlab-runner)**

:   Se connecter avec l'utilisateur `gitlab-runner` (`sudo -iH` et `su gitlab-runner`), puis créer une clé ssh :

    ```bash title="Commande(s) bash" linenums="1"
    ssh-keygen -t rsa
    ```

**Chaque environnement à gérer**

:   Pour chaque host (environnement) que vous souhaitez configurer/gérer créez l'utilisateur `ansible` :

    ```bash linenums="1"
    sudo useradd ansible --home /ansible --create-home --shell /bin/bash --gid staff -G sudo # (1)
    sudo passwd ansible # (2)
    ```

    1.  :man_raising_hand: Création de l'utilisateur `ansible` avec le home `/ansible`, et les groupes staff (principal) et sudo.
    2.  :man_raising_hand: Changement du mot de passe de l'utilisateur.

**Environnement du runner (gitlab-runner)**

:   Ajouter la connexion avec la clé ssh sur chaque host :

    ```bash title="Commande(s) bash" linenums="1"
    ssh-copy-id -p <port-ssh> ansible@<nom-environnement>
    ```

### 02.2 - Configuration de votre projet ansible sur Gitlab

Pour la configuration de votre projet, vous pouvez suivre les conseils disponibles sur la documentation officiel d'Ansible.

[Documentation Officielle :material-book:](https://docs.ansible.com/){ .md-button }

Pour ce tutoriel on va se baser sur l'arborescence suivante :

```yaml title="arborescence du projet"
inventory/:
    host/:
        group_vars/:
            all/:
                - "vars"
roles/:
tasks/:
files/:

.gitlab-ci.yml
playbook_example.yml
```

Dans votre dossier `group_vars/all` de votre environnement créez le fichier `vars` tel que :

```yaml title="inventory/group_vars/all/vars" linenums="1"
---
ansible_connection: ssh
ansible_user: 'ansible'
ansible_python_interpreter: '/usr/bin/python2.7'

ansible_port: "{{ vault_ansible_port }}"
ansible_ssh_private_key_file: "{{ vault_ansible_ssh_private_key_file }}"
ansible_sudo_pass: "{{ vault_ansible_sudo_pass }}"
```

Les variables vont être déclarées par la suite pour être encryptées dans un fichier `vault`.
Ensuite créez ce fichier encrypté avec `ansible vault` :

```bash title="Commande(s) bash" linenums="1"
ansible-vault create <votre-environnement>/group_vars/all/vault
```

!!! hint
    Vous allez devoir définir un mot de passe, sauvegardez le dans votre tête.

Cela va ensuite ouvrir l'éditeur de fichier `vi`, donc pour écrire dans le fichier appuyez sur la touche `insert` puis écrivez les lignes suivantes :

```yaml title="inventory/group_vars/all/vault" linenums="1"
---
vault_ansible_port: <votre-port-ssh>
vault_ansible_ssh_private_key_file: "/home/gitlab-runner/.ssh/id_rsa" # Ou le répertoire contenant votre clé ssh privée
vault_ansible_sudo_pass: "<mot-de-passe-utilisateur-ansible>"
```

### 02.3 - Configuration de Gitlab CI

Dans les paramètres de votre projet gitlab ansible, ajouter une variable de type fichier contenant votre mot de passe de cryptage ansible vault.

> Je vous conseille également de cocher les cases `protected` et `masked`.
> 

Puis dans votre fichier `.gitlab-ci.yml` ajoutez les lignes suivantes pour appeler un playbook :

```yaml title=".gitlab-ci.yml" linenums="1"
- cat $VARIABLE_GITLAB_DEFINI > .vault_password.txt
- ansible-playbook -i <chemin-de-votre-environnement> -e "<variables-du-playbook>" --vault-password-file .vault_password.txt <nom-du-playbook>
```

## 03 - Annexes

### 03.1 - Exemple du contenu du fichier .gitlab-ci.yml

```yaml title=".gitlab-ci.yml" linenums="1"
variables:
    PLAYBOOK_NAME:
        value: "test_config.yml"
        description: "Playbook name to run"
    ENVIROMENT:
        value: "inventory"
        description: "Environment/inventories name"
    VARIABLES:
        value: "var1=azerty var2=azerty"
        description: "Variables defined for the playbook"

deploy:
    stage: deploy
    only:
        - master
    tags:
        - localhost
        - shell
    script:
        - cat $VAULT_PASSWORD > .lol_c_cache.txt
        - ansible-playbook -i $ENVIROMENT -e "$VARIABLES" --vault-password-file .lol_c_cache.txt $PLAYBOOK_NAME

workflow:
    rules:
        - if: '$CI_PIPELINE_SOURCE == "web"'
          when: always
        - when: never
```

!!! tips "workflow"
    Cette règle permet d'authoriser l'exécution seulement à la main.

:material-robot-happy: Enjoy !
