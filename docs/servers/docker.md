# CONFIGURATION DE DOCKER

## Installation

```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

## Configuration

```sh
sudo usermod -aG docker <votre-utilisateur> # Déconseillé par mesure de sécurité
docker run hello-world # Test
```

## Docker-compose

```sh
sudo apt-get install libffi-dev libssl-dev
sudo apt-get install -y python python-pip
sudo apt-get remove python-configparser

sudo pip install docker-compose
```
