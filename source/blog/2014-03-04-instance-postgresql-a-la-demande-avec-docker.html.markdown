---
title: Instance postgresql à la demande avec Docker
date: 2014-03-04 14:38 CET
tags: sysadm, dev, linux
---
Mais qu'est-ce que je l'apprécie ce docker ! De plus en plus, il s'immisce dans mes usages, d'autant plus qu'il me permet d'avoir les outils dont j'ai besoin facilement, rapidement et surtout de manière complètement isolée de mon système qui reste, du coup et en théorie, propre et léger.

Dernièrement j'avais envie de tester une appli rails choppée sur github, configurée par défaut avec postgresql. Or je n'ai pas de serveur sur ma machine, et pas forcément l'envie d'en ajouter un qui "polluerait" encore un peu plus mon système.

Ma dernière trouvaille en date dans l'[index docker](https://index.docker.io) (une vraie mine d'or) : une image permettant de lancer un [service postgresql](http://index.docker.io/u/kamui/postgresql). La "recette" donnée par l'auteur est assez simple, quelques commandes à taper et hop, une instance postgresql dispo !

Cependant je voulais quelque chose de plus direct, comme si je lançais un service sur ma machine sans pour autant l'installer et le gérer comme tel. Alors j'ai conçu un [petit script](https://gist.github.com/bobmaerten/9329752) à la sauce *init.d* selon les préconisations de l'auteur de l'image par l'utilisation d'un dossier local rattaché à un *data-only container* qui est configurable en début de script.

Toutes ces bases appartient ([à nous ?](http://fr.wikipedia.org/wiki/All_your_base_are_belong_to_us)) à l'utilisateur *docker* qui est admin du serveur, alors j'ai ajouté dans mon .(bas|zs)hrc les variables d'environnement suivantes :

    export PGHOST=localhost
    export PGUSER=docker
    export PGPASSWORD=docker

Il me suffit alors de taper `psql` pour avoir accès à mon instance locale, ou même directement utiliser un classique `rake db:create && rake db:migrate` d'une application rails pour que les bases soient créées et alimentée.

Alors bien sûr, il y a toujours moyen de faire mieux ou d'être plus générique, mais pour le moment, ça me suffit comme cela. *Pull requests accepted, as usual!*


```bash
#!/usr/bin/env bash

PGSQL_DATA_PATH='~/postgresql-data'

function getStatus(){
    CONTAINER_ID=$(docker ps -a | grep -v Exit | grep postgresql-server | awk '{print $1}')
    if [[ -z $CONTAINER_ID ]] ; then
        echo 'Not running.'
        return 1
    else
        echo "Running in container: $CONTAINER_ID"
        return 0
    fi
}

case "$1" in
    start)
        if [ ! -d $PGSQL_DATA_PATH ]; then
            mkdir -p $PGSQL_DATA_PATH
        fi

        docker ps -a | grep -q postgresql-data
        if [ $? -ne 0 ]; then
            docker run -name postgresql-data -v $PGSQL_DATA_PATH:/data ubuntu /bin/bash
        fi

        docker ps -a | grep -v Exit | grep -q postgresql-server
        if [ $? -ne 0 ]; then
            CONTAINER_ID=$(docker run -d -p 5432:5432 -volumes-from postgresql-data \
                -name postgresql-server kamui/postgresql)
        fi
        getStatus
        ;;

    status)
        getStatus
        ;;

    stop)
        CONTAINER_ID=$(docker ps -a | grep -v Exit | grep postgresql-server | awk '{print $1}')
        if [[ -n $CONTAINER_ID ]] ; then
            ID=$(docker stop $CONTAINER_ID)
            ID=$(docker rm $CONTAINER_ID)
            if [ $? -eq 0 ] ; then
                echo 'Stopped.'
            fi
        else
            echo 'Not Running.'
            exit 1
        fi
        ;;

    *)
        echo "Usage: `basename $0`  {start|stop|status}"
        exit 1
        ;;
esac

exit 0
```
