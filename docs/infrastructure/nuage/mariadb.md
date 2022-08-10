# Installation et configuration de MariaDB

Comme les repo de MariaDB ne propose pas de .deb spécialement pour les environnements ARM (ici armhf), on doit le build à la main pour avoir la version LTS (dernière version stable).

## 01 - Mise à jour des repos

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```

## 02 - Pré-requis

```bash
sudo apt-get install devscripts
mkdir /opt/mariadb && cd /opt/mariadb
```

## 03 - Serveur

```bash
git clone --recursive --depth 1 --branch 10.7 https://github.com/MariaDB/server.git
cd server
sudo mk-build-deps debian/control --install --remove
sudo ./debian/autobake-deb.sh
```

## 04 - Galera

```bash
cd /opt/mariadb
git clone --recursive --depth 1 --branch mariadb-4.x https://github.com/MariaDB/galera.git
cd galera
sudo mk-build-deps debian/control --install --remove
sudo wget https://gist.githubusercontent.com/ADarkDividedGem/b28f1e35e07a790b42c5fd5f15e3ebee/raw/b02ff575d9805df4c9960603eb18912226657dd3/galera_atomic.patch
sudo patch -p1 < galera_atomic.patch
sudo ./scripts/build.sh -p -j 1
```

## 05 - Packages

```bash
mkdir -p /usr/local/repo/binary
mv ~/mariadb/*.deb /usr/local/repo/binary
cd /usr/local/repo
dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz

sudo su -c "echo 'deb [trusted=yes] file:///usr/local/repo binary/' > /etc/apt/sources.list.d/mariadb.list"
sudo apt-get update

apt show mariadb-server
sudo apt install mariadb-server
sudo service mariadb restart
sudo mysql_secure_installation
```
