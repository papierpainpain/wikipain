# Sécurité

## 01 - Mises-à-jour

!!! warning "Attention"
    Il est fortement recommandé de faire les mises-à-jour ! C'est simplement une question de sécurité.

```bash
sudo apt update
sudo apt upgrade
sudo reboot # Redémarre votre raspi
```

## 02 - Configuration SSH

!!! abstract "Description"
    L'ajout d'un groupe SSH permet de restreindre les accès à votre serveur.

Créez un groupe pour l'accès par ssh :

```bash
sudo groupadd nomgroupessh
```

Ajoutez l'activation par les utilisateurs d'un groupe :

```bash
sudo nano /etc/ssh/sshd_config 
# Ajoutez la ligne 'AllowGroups nomgroupessh' dans le fichier 'sshd_config'

sudo adduser nomutilisateur nomgroupessh # Ajout de 'nomutilisateur' au groupe ssh
sudo systemctl restart sshd # Redémarrer le service ssh
```

Désactivez l'utilisateur root dans ssh :

```bash
sudo nano /etc/ssh/sshd_config
```

Commentez la ligne suivante (avec "#" devant la ligne) :

```conf
#PermitRootLogin prohibit-password
```

Redémarrez le service ssh :

```bash
sudo service ssh restart # Redémarrer le service
```

Changement du port par défaut :

```bash
sudo nano /etc/ssh/sshd_config
```

Trouvez la ligne 'Port' et choisissez un autre port (vérification des ports [disponible ici](https://www.frameip.com/liste-des-ports-tcp-udp/)) :

```bash
Port 1111
```

Connexion ssh avec un port différent :

```bash
ssh nomutilisateur@adresseip -p 1111
```

!!! tip "Astuce"
    l'option **-p** permet de préciser le port pour la connexion.

## 03 - Mises-à-jour de sécurité automatique

!!! abstract "Description"
    Ici, on met en place les mises-à-jour de sécurité automatiquement grâce au paquet **unattended-upgrades**.

```bash
sudo apt install unattended-upgrades
```

Modifiez ensuite le fichier de configuration :

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

Activez la ligne suivante :

```conf
Unattended-Upgrade::Mail "votreadressemail@exemple.com";
```

Définissez les intervalles de mises-à-jour dans le fichier suivant :

```bash
sudo nano /etc/apt/apt.conf.d/02periodic
```

Collez ou modifiez les lignes suivantes :

```conf
APT::Periodic::Enable "1";
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "1";
APT::Periodic::Verbose "2";
```

## 04 - Fail2Ban

!!! abstract "Description"
    **Fail2Ban** permet de limiter les connexions aux services. Par défaut vous n'aurez que 5 tentatives de connexion avec échec autorisées (après il est mis en place un délai pour la connexion).

```bash
sudo apt install fail2ban
sudo service fail2ban restart
```

## 05 - Pare-feu

```bash
sudo apt install ufw # Installation du Pare-feu
sudo ufw allow 1111 # Activation du port 1111
sudo ufw enable # Activation du pare-feu
sudo ufw status verbose # Vérification des ports ouverts
```
