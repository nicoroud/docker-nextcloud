---
ID: 45
post_title: >
  Mise en place d’un serveur owncloud
  sur le LCS
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/mise-en-place-dun-serveur-owncloud-sur-le-lcs/
published: true
post_date: 2016-01-18 18:24:20
---
Prérequis

Modification du php.ini

Owncloud n'accepte pas la directive register global. Il faut donc la mettre à "off" dans /etc/php5/apache2/php.ini

Création de la base de donnée pour owncloud

Récupérer d'abord le mot de passe root de mysql. À l'aide de phpmyadmin, créer une base de donnée : owncloud_db. On crée ensuite un utilisateur mysql owncloud qui aura les privilège sur la base.

Installation d'owncloud

Télécharger la version stable d'owncloud (aujourd'hui, version 7.0.3)

<pre class="lang:bash decode:1 " >
wget http://download.owncloud.org/community/owncloud-7.0.3.tar.bz2
</pre>

Vérifier l'intégrité du paquet avec md5sum et décompresser l'archive

<pre class="lang:bash decode:1 " >
tar xvjf owncloud-7.0.3.tar.bz2
</pre>

Cela crée un répertoire owncloud. Déplacer ce répertoire ver /var/www/

<pre class="lang:bash decode:1 " >
mv owncloud /var/www/cloud
</pre>

Configurer owncloud

Nous lançons l'interface d'owncloud depuis un poste du réseau à l'adresse http://ip_du_lcs/cloud et nous renseignons les données demandées.

Mise en place d’un serveur ownCloud, utilisation de l’annuaire du SE3, gestion du partage de documents..