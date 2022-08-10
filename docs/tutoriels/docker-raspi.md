# Installation de docker sur Raspberry Pi

!!! example "Documentation"
    Tutoriel (ou plutôt synthèse) basé sur celui le tutoriel de **La Grotte du Barbu** :

    [:material-book: Installer Docker sur son Raspberry](https://www.grottedubarbu.fr/installer-docker-raspberry){ .md-button }

## 01 - Installation

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## 02 - Configuration

```sh
sudo usermod -aG docker <votre-utilisateur> # Déconseillé par mesure de sécurité
docker run hello-world # Test
```

## 03 - Docker-compose

```sh
sudo apt-get install libffi-dev libssl-dev
sudo apt-get install -y python python-pip
sudo apt-get remove python-configparser

sudo pip install docker-compose
```
