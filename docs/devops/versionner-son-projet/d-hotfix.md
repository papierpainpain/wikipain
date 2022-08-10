# Hotfix (La nouvelle version est buguée)

Normalement, ça n'arrive jamais parce que vous avez super bien vérifié tous les procédés lors de la phase de pre-production. Mais bon malheureusement des fois il y a un problème !

Si vous suivez les instructions juste en dessous, tout fonctionnera !

<figure markdown>
![Faire un hotfix](/images/versionner-son-projet/hotfix.jpg){ width="100%" }
<figcaption>Faire un hotfix</figcaption>
</figure>

## 01 - Créer le ticket de hotfix

Définissez clairement les problèmes rencontrés et lors de la création du ticket vous devez choisir pour le type : `Bug`.

## 02 - Créer la branche de hotfix

Comme pour les autres types de tickets, vous créez la branche `<numero-du-ticket>` (c'est le numéro du ticket, par exemple `ENGL-1900`). Il faut que la branche soit créée à partir de la branche `master`.

```bash
git checkout master # On se place sur la branche master
git checkout -b <nom-du-ticket> # On crée la branche
```

## 03 - Développer la branche de hotfix

Dans cette étape, vous avez juste à faire votre ticket.

Quelques conseils tout de même :

* Votre code doit être lisible et compréhensible ;
* Mettre de la documentation (:pleading_face: s'il vous plaît...) ;
* Tester votre code ;
* Faire des commits réguliers pour retrouver plus rapidement les bugs ou éléments qui vous intéressent au cours du développement.

Pour faire un commit, il faut :

```bash
git add mon_fichier # On ajoute les modifications à la branche
git commit -m "message décrivant ce que vous avez fait"
git push origin <nom-du-ticket> # Mise à jour de la branche distante
```

## 04 - Changer de version

Comme vous avez apporté des modifications, vous devez changer la version de votre projet.
Pour cela, il suffit d'incrémenter le dernier chiffre de la version (exemple : `1.0.0` => `1.0.1`) dans tous les fichiers contenant la version.

## 05 - Ajouter le ticket dans la release notes

Ajoutez le ticket dans la section `Release notes` de votre fichier `README.md`. Sous la forme suivante :

```md
## Release note

### Hotfix version 1.0.1

| Type | Ticket    | Sujet              |
| ---- | --------- | ------------------ |
| Bug  | ENGL-1243 | Correction bêtises |
```

## 06 - Merge Request

On refait exactement pareil que pour la **Phase de développement** mais en changeant la branche de destination en mettant `master`. Donc on retrouve les étapes suivantes :

* [Faire sa Merge Request](/tutoriels/gestion-projet/versionning/a-phase-developpement/#04-faire-sa-merge-request) ;
* [Vérifier une Merge Request](/tutoriels/gestion-projet/versionning/a-phase-developpement/#05-verifier-une-merge-request).

## 07 - Cherry-pick

Vous devez également faire un Cherry-pick pour merger la branche du hotfix dans la branche `develop`.

<figure markdown>
![Bouton de validation de la Merge Request](/images/versionner-son-projet/merged-btn-mr.png){ width="100%" }
<figcaption>Bouton de validation de la Merge Request</figcaption>
</figure>

Pour cela, après avoir mergé la branche (cf. Fig. Bouton de validation de la Merge Request), vous devez cliquer sur Cherry-Pick (cf. Fig. Choix du Cherry-Pick).

<figure markdown>
![Choix du Cherry-Pick](/images/versionner-son-projet/choose-chery-pick.png){ width="100%" }
<figcaption>Choix du Cherry-Pick</figcaption>
</figure>

Puis choisir la branche `develop` pour la nouvelle Merge Request (cf. Fig. Choix de la branche de destination du Cherry-Pick).

<figure markdown>
![Choix de la branche de destination du Cherry-Pick](/images/versionner-son-projet/chery-pick.png){ width="100%" }
<figcaption>Choix de la branche de destination du Cherry-Pick</figcaption>
</figure>

## 08 - Tag

Enfin pour le tag, dans Gitlab, rendez-vous sur la branche `master`. Cliquez sur le :material-plus-circle: puis `New tag` (cf. Fig. Créer un tag).

<figure markdown>
![Créer un tag](/images/versionner-son-projet/start-create-tag.png){ width="100%" }
<figcaption>Créer un tag</figcaption>
</figure>

Ensuite, il vous reste à remplir les champs suivants (cf. Fig. Remplir les champs d'un tag) :

* **Tag name** : Votre numéro de version (exemple : `2.0.0`) ;
* **Create from** : `master` ;
* **Message** : Ce que vous voulez ;
* **Release notes** : Vous pouvez remettre la release note de votre fichier `README.md` pour la votre version.

<figure markdown>
![Remplir les champs d'un tag](/images/versionner-son-projet/fields-create-tag.png){ width="100%" }
<figcaption>Remplir les champs d'un tag</figcaption>
</figure>

## 09 - Fini

Votre version est de nouveau prête à être publiée !
