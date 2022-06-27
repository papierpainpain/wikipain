# Cheat Sheet Docker

## Docker

1. Pour vérifier les containers en cours d'exécution dans le docker, utilisez la commande docker ps

    ```bash
    docker ps
    ```

2. Pour obtenir les containers en cours d'exécution et arrêtés

    ```bash
    docker ps -a
    ```

3. Pour exécuter un container

    ```bash
    docker run httpd:2.2.29
    ```

4. Pour obtenir les logs d'un container avec l'ID du container

    ```bash
    docker logs containerid
    ```

5. Pour lister toutes les images

    ```bash
    docker images
    ```

6. Pour pousser les images dans le chemin personnalisé dans votre serveur docker, utilisez la commande suivante

    ```bash
    docker push devopsfolks/httpd:2.2.29
    ```

7. Pour exécuter l'image docker en arrière-plan

    ```bash
    docker run –d httpd
    ```

8. Utilisez la commande docker ps pour vérifier l'ID et le statut du container docker

    ```bash
    docker ps -a # -a pour voir les containers arrêtés
    ```

9. Pour voir le contenu d'une image docker, utilisez la commande suivante

    ```bash
    docker exec -i container-id ls -l
    ```

10. Pour se connecter à l'intérieur du docker, utilisez la commande suivante

    ```bash
    docker exec -it container-id /bin/bash
    ```

11. Arrêter le container

    ```bash
    docker stop container-id
    ```

12. Démarrer le container

    ```bash
    docker start container-id
    ```

13. Pour mapper les ports dans le docker, utilisez les commandes suivantes

    ```bash
    docker run -d -p 8080:80 httpd
    ```

14. Inspection d'un conteneur Docker à l'aide de docker inspect

    ```bash
    docker inspect container-id
    ```

!!! note "Documentation"
    Lien de la documentation ou j'ai presque tout copié (parce que c'est plus pratique d'avoir tout au même endroit ! :clown:) :

    [:material-book: Lien de mon plagiat](https://medium.com/@devopsfolks8546/docker-management-51e7195925d4){ .md-button }

## Docker-compose

```bash
docker-compose up # start services with detached mode
docker-compose -d up # start specific service
docker-compose up <service-name> # list images
docker-compose images # list containers
docker-compose ps # start service
docker-compose start # stop services
docker-compose stop # display running containers
docker-compose top # kill services
docker-compose kill # remove stopped containers
docker-compose rm # stop all contaners and remove images, volumes
docker-compose down
```
