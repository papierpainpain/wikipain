# Serveur De Fichiers Samba

Mise en place d'un serveur de fichiers Samba sur Raspberry Pi.

___
___

## Installation de samba

```bash
sudo apt install samba samba-common-bin

# Fichier de configuration Samba
sudo nano /etc/samba/smb.conf

# Activation des ports sur le pare-feu
sudo ufw allow 445
sudo ufw allow 139
```

## Ajouter un disque externe

### Configuration

Création d'un répertoire de partage :

```bash
sudo mkdir /home/shares
sudo mkdir /home/shares

sudo chown -R root:users /home/shares
sudo chmod -R 775 /home/shares
```

Dans un premier temps, chercher votre disque dur externe avec la commande suivante :

```bash
df -h
```

!!! note "info"
    Ou avec `dmesg`, personnellement j'ai pas trouvé mais en générale c'est **sda1**.

Si votre disque dur n'est pas un système de fichiers Linux reformatez le avec la commande suivante (après avoir sauveardé les données qui étaient dessus pour ne rien perdre) :

```bash
umount /dev/sda1
sudo mkfs.ext4 /dev/sda1
```

### Montage du disque

```bash
sudo mkdir /home/shares/disk1
sudo chown -R root:users /home/shares/disk1
sudo chmod -R 775 /home/shares/disk1
sudo mount /dev/sda1 /home/shares/disk1
```

### Montage automatique au démarrage

```bash
sudo nano /etc/fstab
```

Ajoutez la ligne suivante pour chaque disque que vous ajoutez :

```bash
/dev/sda1 /home/shares/disk1 auto noatime,nofail 0 0
```

## Fichier de configuration Samba

```bash
sudo nano /etc/samba/smb.conf
```

Ceci est un exemple de fichier de configuration Samba :

```conf
#======================= Global Settings =======================

[global]
    netbios name = nananassmb
    workgroup = NANANAS
    server string = Nananas samba

#### Access rights ####
    create mask = 0660
    directory mask = 0770

#### Debugging/Accounting ####
    log file = /var/log/samba/log.%m
    max log size = 1000
    logging = file
    panic action = /usr/share/samba/panic-action %d

####### Authentication #######
    server role = standalone server
    obey pam restrictions = yes
    unix password sync = yes
    passwd program = /usr/bin/passwd %u
    passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    pam password change = yes
    map to guest = bad user

    security = user
    encrypt passwords = true
    passdb backend = tdbsam
    obey pam restrictions = yes

############ Misc ############
    usershare allow guests = no

#======================= Share Definitions =======================

[homes]
    comment = Home Directories
    browseable = no # dossier visible par tous
    read only = no # 'no' pour autoriser l'écriture
    create mask = 0700
    directory mask = 0700
    valid users = %S

[multimedia]
    path = /path/to/folders
    comment = coment about folders
    browseable = yes
    read only = yes
    create mask = 0755
    directory mask = 0755
    valid users = @group_name # utilisateurs et groupes autorisés
    write list = user_name # utilisateurs pouvant écrire
```

## Gestion des utilisateurs Samba

Ajouter un utilisateur :

```bash
sudo useradd -s /bin/false -d /dev/null -g nom_groupe nom_utilisateur # Créer l'utilisateur
sudo smbpasswd -a nom_utilisateur # Ajouter à Samba
```

Appliquez les modifications avec un redémarrage du serveur Samba :

```bash
sudo /etc/init.d/smbd restart
```
