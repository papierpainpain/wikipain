# Monitoring de la Raspberry Pi

Mise en place d'un système de monitoring sur la Raspberry Pi.

Tutoriel basé sur [celui-ci](https://raspberry-pi.fr/monitoring-raspberry-pi/) (en fait c'est simplement une synthèse donc un **copier coller** du tutoriel xD).

___
___

## Installation et configuration

```bash
cd /var/www/html/
```

Prendre la dernière version sur [ezservermonitor](http://www.ezservermonitor.com/esm-web/downloads).

```bash
sudo wget --content-disposition  http://www.ezservermonitor.com/esm-web/downloads/version/2.5

unzip ezservermonitor-web_v2.5.zip
sudo rm ezservermonitor-web_v2.5.zip
mv ezservermonitor-web_v2.5 monitoring # Renomme le dossier en 'monitoring'
```

Maintenant vous pouvez configurer **Apache** pour pointer vers cette adresse.
Et si vous souhaitez configurer certains paramètres, exécuter cette commande :

```bash
nano monitoring/conf/esm.config.json
```
