# Configuration de Rasbian

Ici nous nous occupons de la configuration de la raspi par ssh.

!!! danger "Attention"
    Il est important de bien configurer votre raspi avant toutes utilisations, surtout si vous comptez donner un accès extérieur (serveur distant).

## 01 - Première connexion

Avec un terminale, exécutez cette commande pour un accès en ssh :

```bash
ssh pi@adresse_ip
```

!!! note "Astuce"
    Pour savoir l'adresse ip de votre raspi, vous pouvez la chercher sur votre box internet.

    Pour une box Orange, vous y accédez par le navigateur ici :
    
    [Configuration Livebox Orange](http://livebox/){ .md-button }

Les identifiants de l'utilisateur par défaut sont les suivants :

* Utilisateur : **pi**
* Mot de passe : **raspberry**

Après connexion à la raspi, changez le mot de passe avec la commande :

```bash
passwd
```

!!! danger "Attention"
    Si vous n'avez pas changé le mot de passe... Je vous retrouverai...

    Mais comme vous avez changé le mot de passe, vous pouvez poursuivre !

Comme vous êtes soucieux de la sécurité de votre petite raspi (et de l'intégrité de vos données), on va aussi changer l'utilisateur par défaut :

```bash
sudo adduser nomutilisateur # Création du nouveau utilisateur
sudo usermod -a -G pi,adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,lpadmin,gpio,i2c,spi,www-data nomutilisateur # Ajout de tout les groupes dont pi fait partie
sudo usermod -g users nomutilisateur # Ajouter le groupe 'users' comme groupe principal
sudo usermod --expiredate 1 pi # Désactiver l'utilisateur pi

sudo usermod -d /newhome/username nomutilisateur # Modifier le home de l'utilisateur
```

!!! success "Explication"
    Je préfère simplement désactiver l'utilisateur **pi** car certains programmes peuvent encore en avoir besoin bien que c'est de moins en moins le cas.

!!! tip "Astuce 1"
    Pour supprimer un utilisateur d'un groupe :
    ```sudo deluser nomutilisateur nomgroupe```

!!! tip "Astuce 2"
    Pour afficher la liste des utilisateurs :
    ```cat /etc/passwd | awk -F: '{print $ 1}'```

!!! tip "Astuce 3"
    Pour afficher la liste des groupes :
    ```cat /etc/group | awk -F: '{print $ 1}'```

## 02 - Paramètres globaux

Je ne rentrerai pas dans les détails mais vous pouvez modifier de nombreux paramètres grâce à cette commande (pour en savoir plus vous trouverez des [informations ici](https://www.raspberrypi.org/documentation/configuration/raspi-config.md)) :

```bash
sudo raspi-config
```
