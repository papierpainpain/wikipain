# Accès aux fichiers Seafile avec WebDAV

!!! summary "Informations générales"
    Tutoriel basé sur celui de Nextcloud qui marche très bien ! ([Accès aux fichiers Nextcloud avec WebDAV](https://docs.nextcloud.com/server/latest/user_manual/fr/files/access_webdav.html#creating-webdav-mounts-on-the-linux-command-line))

## Description

Seafile supporte le protocole WebDAV, et vous pouvez vous connecter et synchroniser vos fichiers avec le protocole WebDAV.
Ce tutoriel va vous permettre de configurer votre compte sur un environnement Linux.

Nous allons donc, créer un point de montage WebDAV en ligne de commande Linux.

## Configuration

!!! quote ""
    La démarche suivante montre comment créer un point de montage personnel et activer sa connexion automatiquement à chaque fois que vous vous connectez à votre ordinateur.

### 1. Installez le driver WebDAV `davfs2`
   
Il autorise le montage de partages WebDAV comme n’importe quel autre filesystem distant.

* Sur Debian/Ubuntu :

    ```bash
    sudo apt-get install davfs2
    ```

* Sur CentOS, Fedora, et openSUSE :

    ```bash
    sudo yum install davfs2
    ```

* Sur Manjaro

    ```bash
    yay -S davfs2
    # OU
    pacman -S davfs2
    ```

### 2. Ajoutez vous au groupe `davfs2`
   
```bash
sudo usermod -aG davfs2 $USER
```

!!! quote
    Vous devez vous reconnecter pour que votre groupe soit pris en compte.

### 3. Créez les répertoires de montage

Créez un répertoire `nuage` dans le répertoire racine pour votre point de montage, et `.davfs2/` pour votre fichier de configuration personnel.
   
```bash
mkdir ~/nuage # Ou ce que vous voulez
mkdir ~/.davfs2
```

### 4. Copiez `/etc/davfs2/secrets` dans `~/.davfs2`

```bash
sudo cp /etc/davfs2/secrets ~/.davfs2/secrets
```

### 5. Changez les permissions

```bash
sudo chown $USER:$USER ~/.davfs2/secrets
sudo chmod 600 ~/.davfs2/secrets
```

### 6. Configurez le serveur dans le fichier `secrets`

Ajoutez vos information de connexion Seafile à la fin du fichier secrets, en mettant l’URL de votre serveur, l’identifiant (votre mail) et le mot de passe de votre compte Seafile.

```conf
https://nuage.papierpain.fr/seafdav/ <votre-mail> <votre-mot-de-passe>
```

### 7. Configurez le point de montage `/etc/fstab`

A la fin du fichier `/etc/fstab`, ajoutez la ligne suivante :

```conf
https://nuage.papierpain.fr/seafdav/	/home/<utilisateur-linux>/nuage	davfs	user,rw,auto	0	0
```

### 8. Testez la connexion

Ensuite testez le montage et l’authentification en exécutant la commande suivante. Si votre configuration est correcte, vous n’avez pas besoin de passer en mode root.

```bash
mount ~/nuage
```

Pour démonter le point de montage, exécutez la commande suivante :

```bash
umount ~/nuage
```

## Fini !

Maintenant, chaque fois que vous vous connecterez à votre système Linux, votre partage Seafile devrait automatiquement se connecter via WebDAV dans votre répertoire `~/nuage`.

Si vous préférez le monter manuellement, remplacez `auto` par `noauto` dans `/etc/fstab`.
