# WikiPain

## Description

Site de documentation avec le thème Material pour MkDocs.

* Le wiki est disponible sur [wiki.papierpain.fr](https://wiki.papierpain.fr) ;
* Documentation de [Material MKDocs](https://squidfunk.github.io/mkdocs-material/reference).

## Configuration

```bash
sudo apt install python3-pip
pip3 install mkdocs
```

Si le terminal vous signale un chemin (PATH) absent, l'ajouter avec :
    
```bash
export PATH="/le/chemin/a/ajouter:$PATH"
```

Ensuite installer les dépendances avec :

```bash
pip3 install mkdocs-material # Le thème Material
pip3 install mkdocs-static-i18n # L'internationalisation
```

## Développement

Pour modifier en direct la documentation, vous pouvez utiliser la commande `mkdocs serve` :

```bash
mkdocs serve --dirtyreload
```

### Arborescence

Voici l'arborescence et le fonctionnement :

* <u>__/mkdocs.yml__</u> : fichier utilisé pour la configuration du wiki (thème, plugins, contenu du menu...) ;
* <u>__/docs/__</u> : Dossier utilisé pour la compilation du wiki avec mkdocs ;
* <u>__/docs/index.md__</u> : Page d'accueil ;
* <u>__/docs/infrastructure/__</u> : Documentations sur mon infrastructure ;
* <u>__/docs/devops__</u> : Documentations sur les outils et les procédés DevOps ;
* <u>__/docs/tutoriels__</u> : Tutoriels ;
* <u>__/docs/cheat-sheet__</u> : Cheat-sheets ;
* <u>__/docs/ressources__</u> : Ressources.

### Contenu des fichiers

Pour écrire la documentation, vous pouvez utiliser la syntax markdown classique.

Il y a en plus plusieurs extensions avec des conventions d'écriture. Par exemple, vous avez l'extension Admonition pour avoir des notes d'information.

Syntax de l'extension Admonition :

```md
!!! type "Titre optionnel avec les guillemets doubles"
    Texte du bloc avec une indentation.

    Second paragraphe.
```

Les types possibles : __attention__, __caution__, __danger__, __error__, __hint__, __important__, __note__, __tip__, et __warning__.

Exemple d'utilisation :

```md
!!! caution
    Lorem Ipsum

!!! danger "Titre du bloc Danger"
    Lorem Ipsum
```
