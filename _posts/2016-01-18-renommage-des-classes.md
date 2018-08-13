---
ID: 65
post_title: Renommage des classes
author: nicolas
post_excerpt: ""
layout: post
permalink: https://rouni.fr/renommage-des-classes/
published: true
post_date: 2016-01-18 19:04:13
---
Suite à l'initialisation de Gepi, celui-ci propose sur la page d'accueil (dans les "Actions en attente") des changements de classe pour tous nos élèves ("Effectuer le changement de classe de 3_E vers 3 E" par exemple). Solution :

Renommer les classes dans Gepi comme dans SconetCréer un fichiermenage_infos_actions.sql avec :TRUNCATE infos_actions; TRUNCATE infos_actions_destinataires; Uploader ce fichier via

Gestion générale &gt; Sauvegardes et restauration

(en bas de page)Sous Fichiers de restauration, cliquer sur

Restaurer

en face du nom du fichier.