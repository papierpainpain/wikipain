# Rappel sur les versions

La version d'un logiciel correspond à son état à un moment donné. Il se caractérise souvent par un numéro de version, par exemple `1.0.0` ou `1.0.1`.

Dans l'explication suivante on pose la version telle que `A.B.C`. Il y a différents types d'évolutions :

* :material-book-arrow-up: Les évolutions majeures, elles apportent des nouvelles fonctionnalités importantes, voire même une restructuration complète du logiciel. Ici `A` serait le chiffre à incrémenter ;
* :material-puzzle: Les évolutions mineures, elles apportent des corrections de bugs ou des fonctionnalités secondaires. Ici `B` serait le chiffre à incrémenter ;
* :material-bug: Les hotfixes, elles corrigent des bugs vitaux présents sur la version en production (sur `master`). Sans ce correctif, l'application ne fonctionne pas correctement. Ici `C` serait le chiffre à incrémenter.

!!! quote "La version GoRoCo"
    Ce système de version ressemble énormément au précédent, mais avec une certaine souplesse sur l'incrément des numéros. Cela permet de s'adapter à des projets plus complexes.

    **GoRoCo** est un aide-mémoire qui signifie : **G** pour **Génération**, **R** pour **Révision**, **C** pour **Correction**. Les "o" viennent s'intercaler entre les lettres de l’acronyme, lui permettant d'être prononcé et retenu plus facilement.

Nous concernant, voici les différents types de version que nous avons :

* `A.B.C-SNAPSHOT` : C'est la version qui est en cours de développement (phase de développement) ;
* `A.B.C-RELEASE` : C'est la version qui est en pré-production (phase de préparation de cette version) ;
* `A.B.C` : C'est la version qui est en production (phase de mise en production).

Ensuite pour la signification de `A`, `B` et `C`, c'est exactement la même chose que plus haut.

!!! exemple "Documentation"
    Pour en savoir plus sur le versionning de projet, je vous conseille d'aller voir le lien suivant :

    [:material-book: Version d'un logiciel (Wikiwand)](https://www.wikiwand.com/fr/Version_d%27un_logiciel){ .md-button }
