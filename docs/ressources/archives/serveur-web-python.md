# Serveur Web Python (Raspberry Pi)

!!! warning "Attention"
    Documentation en cours de rédaction.

    Elle peut donc comporter des erreurs. N'hésitez pas à me les signaler par [mail ici](https://www.gourves-steven.fr/#contact).
    
    Merci et Bonne lecture !

Mise en place d'un serveur web pour une application Python sur Raspberry Pi.

## 01 - Configuration de l'environnement

Installation et configuration [d'Apache](/raspi/servers/web/#installation-dapache).

### 01.1 - Installation de Passenger

```bash
sudo apt install dirmngr gnupg
sudo apt install apt-transport-https ca-certificates
sudo apt install libapache2-mod-passenger
```

### 01.2 - Activer le module Apache Passenger

```bash
sudo a2enmod passenger
sudo systemctl reload apache2
```

### 01.3 - Installation de Bottle

```bash
pip3 install bottle
```

## 02 - Configuration du site sous Apache

!!! tips "Astuce"
    Vous pouvez très bien modifier "**nomSite.votredomaine.fr**" en "**votredomaine.fr**" ou "**votredomaine.fr/nomSite**".

```conf
<VirtualHost *:80>
    ServerName nomSite.votredomaine.fr
    DocumentRoot /votre/path/www/nomSite/public
    PassengerAppRoot /votre/path/www/nomSite

    PassengerAppType wsgi
    PassengerStartupFile passenger_wsgi.py

    <Directory /votre/path/www/nomSite>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews
    </Directory>

    CustomLog /var/log/apache2/nomSite.access.log "combined"
    ErrorLog /var/log/apache2/nomSite.error.log
</VirtualHost>
```
