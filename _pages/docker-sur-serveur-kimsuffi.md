---
ID: 567
post_title: Docker sur serveur kimsuffi
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/docker-sur-serveur-kimsuffi/
published: true
post_date: 2018-08-03 16:41:30
---
<p>Après le hack de mon serveur, il a fallu le réinstaller complètement. J'en ai profité pour isoler chacun de mes blogs ainsi que mon cloud dans des conteneurs docker pour plus de sécurité. Les conteneurs sont ainsi isolés les uns des autres.</p>
<h3>Proxy web avec nginx et let'sencrypt</h3>
<p>Source : <a href="https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion" target="_blank" rel="noopener">https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion</a></p>
<p></p>
<h3>Wordpress avec SSL intégré, nginx proxy et renouvellement automatique des certificats letsencrypt</h3>
<p>Source : <a href="https://github.com/evertramos/docker-wordpress-letsencrypt" target="_blank" rel="noopener">https://github.com/evertramos/docker-wordpress-letsencrypt</a></p>
<p></p>
<h3>Nextcloud avec nginx proxy intégré avec letsencrypt</h3>
<p>Source : <a href="https://github.com/evertramos/docker-nextcloud-letsencrypt" target="_blank" rel="noopener">https://github.com/evertramos/docker-nextcloud-letsencrypt</a></p>
<p></p>
<h3>Automatisation</h3>
<p>Script bash :</p>
<pre class="lang:sh decode:true  " title="containerscmd">#!/bin/bash

# 08-07-2018
# Nicolas Roudninski
#

CONTDIR="/opt/docker"
NGINXDIR="/opt/docker/nginx/"
APPSDIR="hg42 rouni osteo nextcloud"


## start docker containers
dockerstart() {
        echo "fonction dockerstart"
        # nginx
        cd $NGINXDIR
        ./start.sh

        # Containers
        for DOCKERDIR in $APPSDIR
        do
                cd $CONTDIR/$DOCKERDIR
                echo "lancement du conteneur $DOCKERDIR"
                docker-compose up -d
                done
        #/opt/docker/trms/start_docker-transmission.sh
}

# stop docker containers
dockerstop() {
        echo "Stoppe tous les conteneurs"
        docker stop $(docker ps -a -q) &amp;&amp; docker rm $(docker ps -a -q)
}

dockerrestart() {
        echo "Relance tous les conteneurs"
        docker stop $(docker ps -a -q) &amp;&amp; docker rm $(docker ps -a -q)
        dockerstart
}

dockerupdate() {
        echo "Mise à jour des conteneurs"
        for DOCKERDIR in $APPSDIR
        do
                cd $CONTDIR/$DOCKERDIR
                docker-compose pull
                docker-compose up -d --remove-orphans
        done
        docker image prune -f 2&gt;&amp;1
}


case "$1" in
        start) dockerstart;;
        stop) dockerstop;;
        restart) dockerrestart;;
        update) dockerupdate;;
        *) echo "usage: $0 start|stop|restart" &gt;&amp;2
                exit 1
                ;;
esac</pre>
<p></p>

<!-- wp:heading {"level":3} -->
<h3>Collabora online</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Source : <a href="https://help.nextcloud.com/t/collabora-configuration-with-docker-compose/3970/3">https://help.nextcloud.com/t/collabora-configuration-with-docker-compose/3970/3</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>docker-compose :<br/>(bien sûr, remplacer "exemple.fr" par le nom du serveur...)</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>version: '3'

services:
   collabora-app:
     container_name: collabora
     image: collabora/code
     restart: unless-stopped
     expose:
       - 9980
     environment:
       - domain=cloud\\.example\\.fr
       - VIRTUAL_PORT=9980
       - VIRTUAL_HOST=office.example.fr
       - VIRTUAL_NETWORK=webproxy
       - VIRTUAL_PROTO=https
       - LETSENCRYPT_HOST=office.example.fr
       - LETSENCRYPT_EMAIL=user@example.com
     cap_add:
       - MKNOD
     networks:
       - default

networks:
    default:
       external:
         name: webproxy</code></pre>
<!-- /wp:code -->