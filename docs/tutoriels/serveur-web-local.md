# Configurer mon serveur PHP en local

## 01 - Sur Windows (rien que pour Alexandre :octicons-heart-fill-24:{ .heart })

### 01.1 - Installation

* [x] Télécharger [**WAMP Server** ici](https://sourceforge.net/projects/wampserver/files/latest/download) ;
* [x] Lancer **WAMP Server**.

### 01.2 - Configuration

Pour bien travailler, il vous faut un nom de domaine en local (ex. : `mon-super-site.loc`), pour cela il faut créer un **Virtual Host**.

* [x] Cliquez sur l'icone W en bas à droite de votre écran ;
* [x] Choisissez un nom (ex. : `mon-super-site.loc`) ;
* [x] Choisissez le répertoire du git (cloné au préalable) pour pointer sur le dossier contenant le fichier `index.php` ;
* [x] Redémarrer les services ou redémarrer la zone DNS (avec : clique droit + outils).

## 02 - Sur Linux

### 02.1 - Installation

* [x] Télécharger Apache et PHP (cf. [super tuto ici](https://wiki.papierpain.fr/servers/web/lamp/#configuration-de-lenvironnement-lamp)).

### 02.2 - Configuration

!!! tip "Astuce"
    Vous pouvez (normalement) cloner le projet dans votre dossier Public puis faire un lien symbolique (ce qui sera plus propre).

1. Cloner le projet dans `/var/www/html/` et vérifier les droits (755 : www-data:www-data) ;
2. Dans apache (`/etc/apache2/sites-available/`) créer un fichier de configuration (Ex. : `mon-super-site.conf`) avec les informations suivantes :

    ```conf
    <VirtualHost *:80>
        ServerName mon-super-site.loc
        DocumentRoot /var/www/html/mon-super-site/

        <Directory /var/www/html/mon-super-site>
            Require all granted
            AllowOverride All
            Options FollowSymLinks MultiViews
        </Directory>

        CustomLog /var/log/apache2/projetwebbdd.access.log "combined"
        ErrorLog /var/log/apache2/projetwebbdd.error.log
    </VirtualHost>
    ```

    !!! hint "Astuce"
        `/var/www/html/mon-super-site` Correspond au repertoire du git (ou au symlink) qui pointe sur le dossier contenant le fichier `index.php`.

3. Activer le site et relancer apache :

    ```bash
    sudo a2ensite mon-super-site # Active le site.
    sudo systemctl reload apache2 # Relance apache.
    ```

4. Ajouter le **ServerName** dans les hosts :

    ```bash
    sudo nano /etc/hosts
    ```

5. Dans le fichier ajouter :

    ```txt
    127.0.0.1    mon-super-site.loc
    ```

## Vous pouvez coder !
