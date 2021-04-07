# Installation Rasbian

Pour installer Rasbian (maintenant appelé *Raspberry Pi OS*) retrouvez le lien de [téléchargement ici](https://www.raspberrypi.org/software/).

Choisir :

* L'OS par défaut
* La carte SD de votre raspi

Et enfin lancez l'installation.

Pour une connexion sans écran ni clavier (donc en ssh), créez un fichier "ssh" (sans extensions) dans la partition boot (ce sera la seule partition visible sous windows).

Sous linux vous pouvez créer le fichier en ligne de commande avec :

```bash
touch /boot/ssh
```

Vous pouvez ensuite mettre votre carte SD dans la raspberry pi et faire le branchement ethernet et celui de l'alimentation.
