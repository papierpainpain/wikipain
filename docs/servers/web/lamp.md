# Serveur Web

Mise en place d'un serveur web sur Raspberry Pi.

___
___

## Configuration de l'environnement (LAMP)

L'environnement **LAMP** est l'environnement que j'ai sélectionné pour le serveur car c'est généralement celui que vous retrouverez sur les serveurs Web (tel que proposé par OVH par exemple).

**LAMP** signifie **Linux** (le système d'exploitation), **Apache** (serveur HTTP le plus populaire devant Nginx), **MySQL** (pour la base de données) et **PHP** (Langage pour créer des pages web dynamiques).

Premièrement, mettez à jour votre système (Cf. [mises à jour](/raspi/start/securite/#mises-a-jour))

### Installation d'Apache

```bash
sudo apt install apache2
```

Changez les droit d'acces :

```bash
sudo chown -R $USER:www-data /var/www/html/
sudo chmod -R 770 /var/www/html/
```

### Installation de PHP

```bash
sudo apt install php php-mbstring
```

### Installation de MySQL

```bash
sudo apt install mariadb-server php-mysql
```

Configurez MySQL en changeant l'utilisateur root (renforce la sécurité)

* Se connecter à la base :

```bash
sudo mysql --user=root
```

* Configuration :

```sql
DROP USER 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED BY '[votreMotDePasse]';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
```

* Maintenant pour se connecter à la base :

```bash
sudo mysql -u root -p
```

### Installation de PHPMyAdmin

```bash
sudo apt install phpmyadmin
# choix : "apache" puis "non".

sudo phpenmod mysqli
sudo systemctl reload apache2

sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

## Ajout du site en HTTPS

### Configuration requise

* Apache 2 (cf. [Configuration de l'environnement](/raspi/servers/web/#configuration-de-lenvironnement-lamp))
* Certbot (cf. [Installation de Certbot](/raspi/servers/web/#installation-de-certbot))

### Configuration Linux

Lignes de commandes pour ajouter un site et faire une redirection en https avec un certificat SSL certifié (avec [certbot](https://certbot.eff.org))

```bash
cd /etc/apache2/sites-available/  # Repertoire de configuration apache.
```

Créez et ouvrez le fichier de configuration Apache du site (Exemple de [fichier ici](/raspi/servers/web/#exemple-fichier-de-configuration-apache))

```bash
sudo nano nomSite.conf
```

Activation du site et application des modifications apache :

```bash
sudo a2ensite nomSite # Active le site.
sudo systemctl reload apache2 # Relance apache.
```

Mettre en place la redirection (https) et le certificat SSL avec **certbot** :

```bash
sudo certbot --apache # Crée la redirection et le certificat SSL
```

!!! danger "attention"
    Si vous devez la configuration OVH faites la avant la mise en place de la redirection de certbot !

!!! note
    Lorsque vous lancez la commande cela va vous lister tous vos sites, et cela vous demandera quel site choisir donc sélectionner le ou tous les sites si vous le souhaitez.

!!! note
    Ensuite, cela vous demandera de mettre la redirection (ajout automatique des lignes dans votre fichier *nomSite.conf*) donc si vous le souhaitez, acceptez (normalement la réponse *2*).

### Configuration OVH

La configuration OVH (ou de votre propre hébergeur) sert à avoir un sous-domaine nous permettant d'acceder à notre **NAS** sans utiliser l'adresse IP en brut (et puis sinon c'est pas beau !).

Sur [ovh.com](https://www.ovh.com) :

* *Web Cloud* > *Domaines*
* Sélectionner votre nom de domaine
* *DynHost*
* *Ajouter un DynHost*
* Remplir le nom du sous-domaine et l'adresse IP
* Enregistrer

!!! note
    Si vous utilisez un sous-domaine pour rediriger sur votre **NAS** maison, mettez l'adresse IP de votre box.

!!! note
    Noubliez pas d'activer les ports de votre box (cf. la [section configuration de votre box](/raspi/servers/web/#configuration-de-la-box) et si vous avez un parefeu, ceux de votre raspberry (cf. la [section sécurité](/raspi/start/securite)).

!!! note
    Si vous utilisez un autre hébergeur, vous devrez chercher la section *DynHost* de votre nom de domaine (si votre fournisseur le propose).

### Configuration raspi pour dynhost ovh

!!! danger "attention"
    Mise à jour de la documentation avec le [dynhost-update ici](https://gitlab.papierpain.fr/nananas/dynhost-update).

```bash
sudo wget https://raw.githubusercontent.com/RaspbianFrance/dyndnsovh/master/dyndns.sh -O /usr/local/sbin/dyndns.sh
sudo chmod 700 /usr/local/sbin/dyndns.sh

sudo nano /usr/local/sbin/dyndns.sh
```

```sh
DYNHOST_ID='[votrenomdedomaine.fr-XXXX]'
DYNHOST_PASSWORD='[motdepasse]'
DOMAIN_NAME='[*.sousdomaine.fr]'
```

[Site raspberry-pi.fr sur les noms de domaine](https://raspberry-pi.fr/nom-domaine/)

## Certbot

### Installation

Installer **snapd**

```bash
sudo apt update
sudo apt install snapd
```

Vérification installation et mise à jour

```bash
sudo snap install core
sudo snap refresh core
```

Installer **Certbot**

```bash
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

### Utilisation

Installation d'un certificat (avec la liste des domaines) :

```bash
sudo certbot --apache
```

Supprimer un certificat :

```bash
certbot delete --cert-name example.com
# or to choose from a list:
certbot delete
```

## Configuration de la box

Exemple de configuration de votre box (Ici avec une box orange) afin d'accéder depuis l'exterieur à votre nas.

## Annexes

Retrouvez toutes les annexes de la documentation.

### Exemple fichier de configuration Apache

!!! tips
    Vous pouvez très bien modifier "***nomSite.nom-domaine.fr***" en "***nom-domaine.fr***" ou "***nom-domaine.fr/nomSite***".

```conf
<VirtualHost *:80>
    ServerName nomSite.nom-domaine.fr
    DocumentRoot /votre/path/www/nomSite/

    <Directory /votre/path/www/nomSite>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews
    </Directory>

    CustomLog /var/log/apache2/nomSite.access.log "combined"
    ErrorLog /var/log/apache2/nomSite.error.log
</VirtualHost>
```
