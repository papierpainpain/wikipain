# Installation et configuration de Seafile

Seafile permet la gestion de fichiers en cloud (comme un nextcloud ou un google drive mais en auto-hébergé et en plus léger !).

**Version : 9.0.x**

!!! summary "Description"
    Ce tutoriel explique comment déployer et exécuter Seafile Server Community Edition (Seafile CE) sur un serveur Linux avec MySQL/MariaDB comme base de données. Le déploiement a été fait (ici) sur un debian 10 chrooté (arm32v7).

    [Documentation Officielle :material-book:](https://manual.seafile.com/deploy/using_mysql/){ .md-button }

## 01 - Installation

### 01.1 - Pré-requis

Mise à jour du système :

```bash
sudo apt-get update
```

Installation des paquets python :

```bash
sudo apt-get install -y python3 python3-setuptools python3-pip libmysqlclient-dev python3-pymysql
sudo apt-get install -y memcached libmemcached-dev
```

Dépendances de la librairie Pillow :

```bash
sudo apt-get install libjpeg-dev
sudo apt-get install zlib1g-dev
sudo apt-get install libpng-dev
```

Installation de toutes les librairies python avec pip :

```bash
sudo pip3 install --timeout=3600 django==3.2.* Pillow pylibmc \
    captcha jinja2 sqlalchemy==1.4.3 django-pylibmc django-simple-captcha \
    python3-ldap mysqlclient pycryptodome==3.12.0 cffi==1.14.0
```

### 01.2 - Création du dossier seafile

Le dossier standard pour gérer l'instance et les versions de seafile est `/opt/seafile`. Créez ce dossier :

```bash
sudo mkdir /opt/seafile
chown -R seafile: /opt/seafile
```

### 01.3 - Création d'un utilisateur seafile

!!! tips "Astuce"
    Une bonne pratique consiste à ne pas exécuter des applications en tant que root.

Créez un nouvel utilisateur et suivez les instructions à l'écran :

```bash
sudo adduser seafile
```

Changez les droits du dossier pour l'attribuer à l'utilisateur seafile :

```bash
chown -R seafile: /opt/seafile
```

Toutes les étapes suivantes sont effectuées avec l'utilisateur seafile.

Changez d'utilisateur avec la commande suivante :

```bash
su seafile
```

### 01.4 - Récupération de l'archive

Téléchargez l'archive depuis [le lien de téléchargement](https://www.seafile.com/en/download/) sur le site web de Seafile en utilisant curl :

!!! warning "Attention"
    Vérifiez le type de processeur et la version de votre debian avant de lancer la commande.

```bash
wget https://github.com/haiwen/seafile-rpi/releases/download/v9.0.2/seafile-server-9.0.2-bullseye-arm32v7l.tar.gz
```

Extraire les fichiers de l'archive :

```bash
tar xf seafile-server-9.0.2-bullseye-arm32v7l.tar.gz
```

Maintenant vous pouvez voir la structure suivante (commande `tree -L 2`) :

```conf
.
|-- seafile-server-9.0.2
|   |-- check_init_admin.py
|   |-- reset-admin.sh
|   |-- runtime
|   |-- seaf-fsck.sh
|   |-- seaf-fuse.sh
|   |-- seaf-gc.sh
|   |-- seafile
|   |-- seafile.sh
|   |-- seahub
|   |-- seahub.sh
|   |-- setup-seafile-mysql.py
|   |-- setup-seafile-mysql.sh
|   |-- setup-seafile.sh
|   |-- sql
|   `-- upgrade
`-- seafile-server-9.0.2-bullseye-arm32v7l.tar.gz

6 directories, 11 files
```

### 01.5 - Configuration de Seafile

Le paquet d'installation est fourni avec un script de configuration de Seafile. Plus précisément, le script crée les répertoires requis et extrait tous les fichiers au bon endroit. Il peut également créer un utilisateur MySQL et les trois bases de données dont les composants de Seafile ont besoin :

* serveur **ccnet** ;
* serveur **seafile** ;
* **seahub**.

!!! info "Note"
    Bien que le serveur **ccnet** ait été fusionné avec le serveur seafile dans Seafile 8.0, la base de données correspondante est toujours requise pour le moment.

Exécutez le script en tant qu'utilisateur seafile :

```bash
cd seafile-server-9.0.2/
./setup-seafile-mysql.sh
```
