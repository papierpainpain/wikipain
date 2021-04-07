# Serveur Seafile (Raspberry Pi)

Mettre en place le serveur de fichiers seafile sur Raspberry Pi.

Tutoriel basé sur [celui-ci](https://manual.seafile.com/deploy/using_mysql/).

___
___

## Installation et Configuration

### 1.  Téléchargement des paquets

```bash
sudo mkdir /opt/seafile
cd /opt/seafile
sudo curl -L https://github.com/haiwen/seafile-rpi/releases/download/v8.0.3/seafile-server-8.0.3-buster-armv7.tar.gz | sudo tar zx
```

### 2.  Les bases de données Mysql

Connectez-vous avec votre utilisateur administrateur (ici root)

```bash
mysql -u root -p
```

Ensuite, créez les bases de données un utilisateur et configurez ses privilèges

```sql
create database `ccnet_db` character set = 'utf8';
create database `seafile_db` character set = 'utf8';
create database `seahub_db` character set = 'utf8';

create user 'seafile'@'localhost' identified by '[MOT_DE_PASSE_CHOISI]';

GRANT ALL PRIVILEGES ON `ccnet_db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seafile_db`.* to `seafile`@localhost;
GRANT ALL PRIVILEGES ON `seahub_db`.* to `seafile`@localhost;
```
