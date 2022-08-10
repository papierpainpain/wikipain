# Installation Rasbian

!!! example "Téléchargement"
    Pour installer Rasbian (maintenant appelé *Raspberry Pi OS*) retrouvez le lien de téléchargement ici :

    [:material-cloud-download: Raspberry Pi OS](https://www.raspberrypi.org/software/){ .md-button }

Choisir :

- [x] L'OS par défaut
- [x] La carte SD de votre raspi

Et enfin lancez l'installation.

Pour une connexion sans écran ni clavier (donc en **ssh**), créez un fichier `ssh` (sans extensions) dans la partition `boot` (ce sera la seule partition visible sous windows).

Sous linux vous pouvez créer le fichier en ligne de commande avec :

```bash
touch /boot/ssh
```

Ensuite, mettez votre carte SD dans la raspberry pi et faire le branchement ethernet et celui de l'alimentation.
