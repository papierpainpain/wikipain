# Serveur De Fichiers Nextcloud

Mise en place d'un serveur de fichiers Nextcloud sur Raspberry Pi.

L'installation de **Nextcloud** développée ci-dessous est une adaptation synthétique de [cette doc](https://pimylifeup.com/raspberry-pi-nextcloud-server/?fbclid=IwAR1l8NZ9ayihXWDSh0BnWeXzhk894EXwt998s0V5YUC_rgi3yrVURydZAfg) en français.

___
___

## Configuration de l'environnement

!!! warning
    Ce tutoriel requière en amont l'installation d'un serveur web comme [développé ici](/raspy/servers/web/).

Vérifiez et faites les mises-à-jour si il y en a :

```bash
sudo apt update
sudo apt upgrade
```

Installez les extensions PHP requises (en complément de celles installées avec l'installation de LAMP) :

```bash
sudo apt install php-gd php-sqlite3 php-curl php-zip php-xml php-mysql php-bz2 php-intl php-smbclient php-imap php-gmp
```

Relancez Apache :

```bash
sudo systemctl reload apache2
```

Configurez de la base de données :

> Connexion à la base de donnée avec l'utilisateur 'root'
> 

```bash
sudo mysql -u root -p
```

```sql
CREATE DATABASE nextclouddb;
CREATE USER 'nextclouduser'@'localhost' IDENTIFIED BY '[votreMotDePasse]';
GRANT ALL PRIVILEGES ON nextclouddb.* TO 'nextclouduser'@'localhost';
FLUSH PRIVILEGES;
```

## Installation de Nextcloud

```bash
cd /var/www/html/
```

Téléchargement de Nextcloud :

```bash
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
```

Extraction du fichier :

```bash
sudo tar -xvf latest.tar.bz2

sudo mkdir -p /var/www/html/nextcloud/data
```

Configuration des droits :

```bash
sudo chown -R www-data:www-data /var/www/html/nextcloud/
sudo chmod 750 /var/www/html/nextcloud/data
```

Créez le fichier de configuration Apache suivant en suivant le tutoriel de [Configuration Web](/raspy/servers/web/) :

```conf
<VirtualHost *:80>
    ServerName nextcloud.votredomaine.fr
    DocumentRoot /var/www/nextcloud/html/

    <Directory /var/www/nextcloud/html>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews

        <IfModule mod_dav.c>
            Dav off
        </IfModule>
    </Directory>

    CustomLog /var/log/apache2/nextcloud.access.log "combined"
    ErrorLog /var/log/apache2/nextcloud.error.log
    RewriteEngine on
    RewriteCond %{SERVER_NAME} =nextcloud.votredomaine.fr
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```
