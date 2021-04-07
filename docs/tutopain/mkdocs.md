# Documentation MkDocs (Tips)

Documentation complète sur [mkdocs.org](https://www.mkdocs.org).

___
___

## Installation

Vérifier qu'il y ai **python** et **pip** sur le serveur (`[nom programme] --version`) puis :

```bash
pip3 install mkdocs
```

Si le terminal vous signale un chemin (PATH) absent, l'ajouter avec :

```bash
export PATH="/le/chemin/a/ajouter:$PATH"
```

## Commandes MKDocs

* `mkdocs new [nomDuSite]` - Créer un nouveau projet.
* `mkdocs build` - Build le site.
* `mkdocs build --clean` - Nettoyage de la Build.
* `mkdocs --help` - Documentation.

## Admonition

Ajouter l'extension **Admonition** dans votre *mkdocs.yml* avec :

```yml
markdown_extensions:
    - admonition
```

Syntax de l'extension :

```md
!!! type "Titre optionnel avec les guillemets doubles"
    Texte du bloc avec une indentation.

    Second paragraphe.
```

Les types possibles : **attention**, **caution**, **danger**, **error**, **hint**, **important**, **note**, **tip**, et **warning**.

Exemples d'utilisation :

!!! caution
    Lorem Ipsum

!!! danger "Titre du bloc Danger"
    Lorem Ipsum

!!! error
    Lorem Ipsum

!!! hint
    Lorem Ipsum

!!! important
    Lorem Ipsum

!!! note
    Lorem Ipsum

!!! tip
    Lorem Ipsum

!!! warning
    Lorem Ipsum
