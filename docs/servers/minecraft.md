# Configuration Serveur Minecraft

Tutoriel basé sur [cette doc](https://raspberry-pi.fr/installer-serveur-minecraft-raspberry-pi/) et [celle-ci](https://www.minecraft.net/fr-fr/download/server).

!!! warning
    Documentation en cours de rédaction.

    Elle peut donc comporter des erreurs. N'hésitez pas à me les signaler par [mail ici](https://www.gourves-steven.fr/#contact).
    
    Merci et Bonne lecture !

___
___

## Pré-requis

Installez les paquets suivants (pour Java) :

```bash
sudo apt-get install software-properties-common
sudo apt update
sudo apt-get install openjdk-8-jdk
```

## Minecraft

```bash
sudo wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
sudo java -jar BuildTools.jar --rev latest # ou le numéro de la version à la place de "latest"
```

Au premier lancement exécutez :

```bash
sudo java -Xmx1G -jar spigot-x.x.jar --port 25560 nogui --world world_name # x.x correspond à la version
sudo sed -i 's/false/true/g' eula.txt # Commande pour accepter les conditions d’utilisation de Minecraft
```

Maintenant, lorsque vous voudrez lancer le server, vous pourrez lancer la commande suivante :

```bash
sudo java -Xmx1G -jar spigot-x.x.jar --port 25560 nogui # x.x correspond à la version
```

## Plugins

- [Github du plugin LOUP-GAROU](https://github.com/leomelki/LoupGarou#installation).
