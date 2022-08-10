# Documentation Lignes de commande Git (Tips)

Documentation sur laquelle je me suis inspiré : [www.hostinger.fr](https://www.hostinger.fr/tutoriels/commandes-git).

!!! note
    Pour en savoir plus, [la documentation se trouve ici](https://git-scm.com/book/fr/v2/Personnalisation-de-Git-Configuration-de-Git).

___
___

## Connexion git

Définir les variables globales avec les commandes suivantes :

```bash
git config --global user.name [votreNom]
git config --global user.email [votreMail]
git config --global core.autocrlf input # correction des sauts de ligne
git config --global core.eol lf # saut de ligne par défaut
```

!!! tips
    Les variables globales ne sont pas requises mais conseilées pour gagner du temps et pour corriger quelques problèmes récurrents.

### SSH Clone

Ici nous allons utiliser la connexion par SSH. Pour cela, vous devez :

- Créer une clé SSH sur votre machine
- L'ajouter sur le Gitlab dans vos compte
- Exécuter le git clone

#### Créer une clé SSH

Pour générer une clé SSH vous dever exécuter la commande suivante (Cf. cette documentation) :

```bash
ssh-keygen -t rsa -b 2048 -C "description"
```

Validez toutes les questions en faisant entrée (Ne rien mettre si vous ne savez pas quoi mettre).

Pour la suite vous aurez besoin de récupérer la clé public que vous pouvez récupérer à l'adresse indiquée lors de la création de la clé (elle sera de forme : ~/.ssh/id_rsa.pub).

#### Configuration de Gitlab pour SSH

- Cliquez sur votre profil
- Edit profile
- Dans le menu latéral gauche : SSH Keys
- Collez la clé dans le champs de text
- Ajoutez votre clé en validant
- Vous n'avez plus qu'à exécuter le git clone :

```bash
git clone ssh://git@gitlab.votredomaine.fr:1111/chemin/vers/repertoire.git
```

!!! note
    Cela sera sensiblement la même procédure pour Github ou encore BitBucket.

Ensuite, pour les commandes globales Git, vous pourrez trouver de la [documentation ici](https://docs.papierpain.fr/tutopain/git/).

### HTTP(S)

```bash
git clone https://gitlab.votredomaine.fr/chemin/vers/repertoire.git
```

## Commandes Git

### Git init

Cette commande est utilisée pour créer un nouveau dépôt GIT :

```bash
git init
```

### Git add

La commande git add peut être utilisée pour ajouter des fichiers à l’index. Par exemple, la commande suivante ajoutera un fichier nommé temp.txt dans le répertoire local de l’index:

```bash
git add temp.txt
```

### Git commit

La commande git commit permet de valider les modifications apportées au HEAD. Notez que tout commit ne se fera pas dans le dépôt distant.

```bash
git commit –m “Description du commit”
```

### Git status

La commande git status affiche la liste des fichiers modifiés ainsi que les fichiers qui doivent encore être ajoutés ou validés. Usage:

```bash
git status
```

### Git push

Git push est une autre commandes GIT de base. Un simple push envoie les modifications locales apportées à la branche principale associée :

```bash
git push origin master
```

### Git checkout

La commande git checkout peut être utilisée pour créer des branches ou pour basculer entre elles.

Créez une branche :

```bash
command git checkout -b <nom-branche>
```

Changez de branche :

```bash
git checkout <nom-branche>
```

### Branche git

La commande git branch peut être utilisée pour répertorier, créer ou supprimer des branches.

Répertorier les branches :

```bash
git branch
```

Pour supprimer une branche :

```bash
git branch –d <nom-branche>
```

### Git pull

Pour fusionner toutes les modifications présentes sur le dépôt distant dans le répertoire de travail local, la commande pull est utilisée. Usage:

```bash
git pull
```

### Git merge

La commande git merge est utilisée pour fusionner une branche dans la branche active. Usage:

```bash
git merge <nom-branche>
```

### Git diff

La commande git diff permet de lister les conflits. Pour visualiser les conflits d’un fichier, utilisez

```bash
git diff --base <nom-fichier>
```

La commande suivante est utilisée pour afficher les conflits entre les branches à fusionner avant de les fusionner:

```bash
git diff <branche-source> <branche-cible>
```

Pour simplement énumérer tous les conflits actuels, utilisez:

```bash
git diff
```

### git archive

La commande git archive permet à un utilisateur de créer un fichier zip ou tar contenant les composants d’un arbre du dépôt. Par exemple:

```bash
git archive --format=tar master
```

### Git rebase

La commande git rebase est utilisée pour la réapplication des commits sur une autre branche :

```bash
git rebase master
```

## Mettre à jour ma branche par rapport à ce que les autres ont poussé ©Julie-la-plus-belle-de-toutes

### 1. Vérifier que la branche actuelle est à jour

```bash
git status
```

Puis soit `push` soit `pull`.

### 2. Mettre à jour le dépot local de la branche commune (des autres)

```bash
git checkout branche_commune
git pull origin branche_commune
```

### 3. Mettre à jour ma branche par rapport à ce que les autres ont poussé 

```bash
git merge branche_commune
```

### 4. Pusher les modifications

```bash
git push origin ma_branche
```

## Mettre à jour l'url de mon dépot local pour avoir du SSH

Parce que ce n'est pas pratique de rentrer ses identifiants à chaque fois !

### 1. Checker mon url actuelle

```bash
git remote -v
# origin  https://domaine.com/user/repo.git (fetch)
# origin  https://domaine.com/user/repo.git (push)
```

### 2. Changer l'url

```bash
git remote set-url origin ssh://git@domaine.com/user/repo.git
```

### 3. Re-checker mon url actuelle

```bash
git remote -v
# origin  ssh://git@domaine.com/user/repo.git (fetch)
# origin  ssh://git@domaine.com/user/repo.git (push)
```