# Serveur Gitlab (Raspberry Pi)

Mettre en place un serveur gitlab sur Raspberry Pi.

Tutoriel basé sur [celui-ci](https://docs.gitlab.com/omnibus/settings/rpi.html) (en fait c'est simplement une synthèse donc un **copier coller** du tutoriel xD).

Vous pouvez trouver [des informations là aussi](https://medium.com/@joscelyn56/install-and-configure-gitlab-on-your-vps-edb5e522b866) pour la configuration d'Apache de gitlab !

___
___

## Installation et Configuration

Premièrement, mettez à jour votre système (cf. [mises à jour](/raspi/start/configuration/#mises-a-jour)).

### L'espace SWAP

Mettre l'[espace SWAP](http://doc.ubuntu-fr.org/swap) à 4Go.

```bash
sudo dphys-swapfile swapoff
sudo nano /etc/dphys-swapfile
```

Dans le fichier modifiez ou ajoutez les lignes suivantes :

```conf
CONF_SWAPSIZE=4096
CONF_MAXSWAP=4096
```

Puis faites :

```bash
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
```

### Installation des dépendances

```bash
sudo apt-get install curl openssh-server ca-certificates apt-transport-https perl
curl https://packages.gitlab.com/gpg.key | sudo apt-key add -
```

Choisir l’option « Site internet » si demandé.

Installer *Postfix* (pour la gestion des mails) :

```bash
sudo apt-get install -y postfix
```

### Ajout du répertoire et installation de Gitlab

```bash
sudo curl -sS https://packages.gitlab.com/install/repositories/gitlab/raspberry-pi2/script.deb.sh | sudo bash
```

Ensuite lancez l'installation en précisant votre nom de domaine ou sous-domaine à la place de `gitlab.votredomaine.fr` :

```bash
sudo EXTERNAL_URL="https://gitlab.votredomaine.fr" apt-get install gitlab-ce
```

!!! tip
    Vous pouvez mettre `http://` à la place de `https://` pour une configuration avec apache

## Bugs

### Ruby_block

Lors du lancement de l'installation, si le téléchargement est trop long et qu'il est bloqué sur la ligne suivante :

```bash
* ruby_block[wait for redis service socket] action run
```

Vous pouvez exécuter la commande suivante dans un autre terminal pour débloquer le téléchargement (cf. [résolution du problème ici](https://gitlab.com/gitlab-org/omnibus-gitlab/-/issues/4257)) :

```bash
sudo /opt/gitlab/embedded/bin/runsvdir-start &
```

### Accès git clone en HTTP.S

!!! caution
    Après installation, il peut subvenir une erreur **500** lors d'un `git clone`. Je n'ai pas trouvé de solutions donc j'utilise la connexion en SSH (avec clé) qui fonctionne parfaitement.

## Optimisations pour la Raspi

Allez dans le fichier de configuration :

```bash
sudo nano /etc/gitlab/gitlab.rb
```

Puis faites les modifications suivantes :

```rb
# Reduce the number of running workers to the minimum in order to reduce memory usage
puma['worker_processes'] = 2
sidekiq['concurrency'] = 9
# Turn off monitoring to reduce idle cpu and disk usage
prometheus_monitoring['enable'] = false
```

Appliquez les changements :

```bash
sudo gitlab-ctl reconfigure
sudo gitlab-ctl restart
```

## Configurer le serveur pour Apache

1. Désactivez NGinx dans le fichier de configuration

```bash
sudo nano /etc/gitlab/gitlab.rb
```

```rb
web_server['external_users'] = ['www-data']
nginx['enable'] = false
```

2. Créez un fichier Apache 'gitlab.conf' (cf. [Configuration Apache](/raspi/servers/web/))

```conf
<VirtualHost *:80>
    ServerName gitlab.votredomaine.fr

    DocumentRoot /opt/gitlab/embedded/service/gitlab-rails/public
    
    ServerSignature Off

    ProxyPreserveHost On
    AllowEncodedSlashes NoDecode

    <Location />
        Require all granted

        ProxyPassReverse http://127.0.0.1:8080
        ProxyPassReverse gitlab.votredomaine.fr
    </Location>

    RewriteEngine on
    # RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
    # RewriteRule .* http://127.0.0.1:8080%{REQUEST_URI} [P,QSA]

    #Set up apache error documents, if back end goes down (i.e. 503 error) then a maintenance/deploy page is thrown up.
    ErrorDocument 404 /404.html
    ErrorDocument 422 /422.html
    ErrorDocument 500 /500.html
    ErrorDocument 503 /deploy.html

    CustomLog /var/log/apache2/gitlab.access.log "combined"
    ErrorLog /var/log/apache2/gitlab.error.log
</VirtualHost>
```

## Connexion à Gitlab avec Git

Définir les variables globales avec les commandes suivantes :

```bash
git config --global user.name [votreNom]
git config --global user.email [votreMail]
git config --global core.autocrlf input
git config --global core.eol lf
```

Ensuite pour faire un `git clone` vous pouvez utiliser plusieurs moyens [présentés ici](). Ici nous allons utiliser la connexion par SSH. Pour cela, vous devez :

- Créer une clé SSH sur votre machine
- L'ajouter sur le Gitlab dans vos compte
- Exécuter le `git clone`

### Créer une clé SSH

Pour générer une clé SSH vous dever exécuter la commande suivante (Cf. [cette documentation](https://gitlab.papierpain.fr/help/ssh/README#generate-an-ssh-key-pair)) :

```bash
ssh-keygen -t ed25519 -C "Titre de votre clé"
```

Validez toutes les questions en faisant entrée (Ne rien mettre si vous ne savez pas quoi mettre).

Pour la suite vous aurez besoin de récupérer la clé public que vous pouvez récupérer à l'adresse indiquée lors de la création de la clé (elle sera de forme : `~/.ssh/id_ed25519.pub`).

### Configuration de Gitlab pour SSH

- Clickez sur votre profil
- **Edit profile**
- Dans le menu latéral gauche : **SSH Keys**
- Collez la clé dans le champs de text
- Ajoutez votre clé en validant

Vous n'avez plus qu'à exécuter le `git clone` :

```bash
git clone ssh://git@gitlab.votredomaine.fr:1111/chemin/vers/repertoire.git
```

Ensuite, pour les commandes globales **Git**, vous pourrez trouver de la [documentation ici](/tutopain/git/).

## Exemple de configuration Gitlab complète

```bash
sudo nano /etc/gitlab/gitlab.rb
```

```rb
external_url 'http://gitlab.votredomaine.fr'

puma['worker_processes'] = 2
sidekiq['concurrency'] = 9
web_server['external_users'] = ['www-data']
nginx['enable'] = false
prometheus_monitoring['enable'] = false
```

## Sources

- [gitlab-installation-raspberry-pi](https://raspberrytips.com/gitlab-installation-raspberry-pi/)
- [Générer une clé SSH](https://gitlab.papierpain.fr/help/ssh/README#generate-an-ssh-key-pair)
