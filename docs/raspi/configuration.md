# Configuration de Rasbian

Ici nous nous occupons de la configuration de la raspi par ssh.

Il est important de bien configurer votre raspi avant toutes utilisations, surtout si vous comptez donner un accès extérieur (serveur distant).

___
___

## Première connexion

Avec un terminale, exécutez cette commande pour un accès en ssh :

```bash
ssh pi@adresse_ip
```

!!! note "tips"
    Pour savoir l'adresse ip de votre raspi, vous pouvez la chercher sur votre box internet.
    Pour une box Orange, allez sur [http://livebox/](http://livebox/) dans votre navigateur.

Les identifiants de l'utilisateur par défaut sont les suivants :

* Utilisateur : **pi**
* Mot de passe : **raspberry**

Après connexion à la raspi, je vous conseille **FORTEMENT** de changer le mot de passe avec la commande :

```bash
passwd
```

Je vous conseille également de changer votre utilisateur par défaut (**pi**) dans le but de renforcer la sécurité de votre raspi.

```bash
sudo adduser nomutilisateur # Création du nouveau utilisateur
sudo usermod -a -G pi,adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,lpadmin,gpio,i2c,spi,www-data nomutilisateur # Ajout de tout les groupes dont pi fait partie
sudo usermod -g users nomutilisateur # Ajouter le groupe 'users' comme groupe principal
sudo usermod --expiredate 1 pi # Désactiver l'utilisateur pi

sudo usermod -d /newhome/username nomutilisateur # Modifier le home de l'utilisateur
```

!!! hint
    Je préfère simplement désactiver l'utilisateur **pi** car certains programmes peuvent encore en avoir besoin bien que c'est de moins en moins le cas.

!!! tip
    Pour supprimer un utilisateur d'un groupe :
    ```sudo deluser nomutilisateur nomgroupe```

!!! tip
    Afficher la liste des utilisateurs :
    ```cat /etc/passwd | awk -F: '{print $ 1}'```

!!! tip
    Afficher la liste des groupes :
    ```cat /etc/group | awk -F: '{print $ 1}'```

## Configuration des paramètres globaux

Je ne rentrerai pas dans les détails mais vous pouvez modifier de nombreux paramètres grâce à cette commande (pour en savoir plus vous trouverez des [informations ici](https://www.raspberrypi.org/documentation/configuration/raspi-config.md)) :

```bash
sudo raspi-config
```
