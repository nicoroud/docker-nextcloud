---
ID: 48
post_title: >
  Régler les permissions sur le serveur
  web
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/regler-les-permissions-sur-le-serveur-web/
published: true
post_date: 2016-01-18 18:26:23
---
Régler les permissions sur le serveur web

La plupart des sites web nécessitent qu’une ou plusieurs personnes puissent intervenir pour modifier le contenu des fichiers et répertoires qui constituent le code du site web. Cela est vrai aussi bien pour les sites les plus simples constitués de pages statiques, que pour les sites les plus sophistiqués construits à partir de CMS comme WordPress et autres frameworks.

Copie du billet :<a href="http://www.yann.com/fr/hebergement-web-sous-gnulinux-quels-permissions-pour-les-fichiers-09/05/2011.html" target="_blank" rel="nofollow">http://www.yann.com/fr/hebergement-web-sous-gnulinux-quels-permissions-pour-les-fichiers-09/05/2011.html</a>

Création du groupe d’administration web


On crée un groupe www-admin comme suit :
sudo addgroup www-admin
On place chacun des utilisateurs concernés dans le groupe avec la commande
sudo adduser &lt;login&gt; www-admin

Permissions sur les fichiers existants


sudo chown -R root:www-admin /var/www
sudo chmod -R 0664 /var/www
…on a attribué tous les fichiers existants à l’utilisateur root et au groupe www-admin, et on a autorisé tous les fichiers en lecture seule pour tout le monde (tous les autres utilisateurs), ce qui permettra àApache (ou tout autre serveur web…) d’y accéder également sans privilège particulier. Les membres du groupe www-admin pourront en revanche également accéder en écriture à tout fichier.

Permissions sur les répertoires existants


cd /var/www
sudo find . -type d -exec chmod 2775 {} \;
Cette commande recherche tous les répertoires pour leur appliquer les droits avec le bit setGid. Ce réglage fait en sorte que tout fichier créé à l’intérieur d’un répertoire prend par défaut l’identifiant de groupe (Group ID = GID) du répertoire. Les fichiers créés par les administrateurs du site web dans son arborescence seront donc automatiquement attribués au groupe www-admin et pas au groupe de chaque utilisateur.

Réglage du umask des administrateurs du site


Deux possibilités :

Changer pour tous les utilisateurs dans /etc/login.defs

UMASK           002
…ou…

Changer uniquement pour les utilisateurs concernés

vi /home/&lt;login&gt;/.profile
umask 002
Ce réglage du umask (user mask = masque d’autorisations par défaut de l’utilisateur) est nécessaire pour que tous les administrateurs du site puisent accéder en écriture aux fichiers créés par d’autres administrateurs du site : en effet, ce “masque” fait en sorte que tout fichier créé sur le système par l’utilisateur concerné soit automatiquement créé avec la permission d’accès en écriture pour les membres du même groupe. Combiné au réglage setGID vu ci-dessus au niveau des répertoires, ce umask permet donc d’attribuer automatiquement un droit d’écriture sur tous les fichiers créés par un administrateur du site pour les membres du groupe www-admin.

Réglage des permissions pour les dossiers où le serveur web doit pouvoir écrire


Comme par exemple /wp-content/uploads pour WordPress
sudo chown -R www-data:www-admin /var/www/wp-content/uploads
sudo chmod -R 775 /var/www/wp-content/uploads
Dans ce cas, en donnant au serveur web la propriété des fichiers et des répertoires, on lui permet d’écrire, écraser ou supprimer les fichiers dans ces emplacements. Dans tous les autres cas, il vaut mieux que le serveur web ne soit jamais le propriétaire des fichiers (utiliser soit root, soit l’utilisateur qui a effectivement créé les fichiers en questions : c’est ce qui se passera une fois les configurations proposées ci-dessus appliquées).