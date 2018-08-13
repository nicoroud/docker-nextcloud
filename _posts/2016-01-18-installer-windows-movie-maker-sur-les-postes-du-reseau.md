---
ID: 60
post_title: >
  Installer Windows Movie maker sur les
  postes du réseau
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/installer-windows-movie-maker-sur-les-postes-du-reseau/
published: true
post_date: 2016-01-18 19:01:58
---
Il faut deux choses :

Créer une fichier .bat contenant la ligne

<code>cacls "c:\Program Files\Movie Maker" /T /E /G utilisateurs:C</code>
Dans la dernière version de Movie Maker, le programme de se trouve dans "<code>C:\Program Files\Windows Live\Photo Gallery</code>"

Donc :

<code>cacls "C:\Program Files\Windows Live\Photo Gallery" /T /E /G utilisateurs:C</code>
(Vérifier le chemin en cas de Windows 7 64 bits)
Pour la suite on suppose que tu as créé ce fichier droits.bat dansProgs/ro/DroitsMM

L'utilitaire CPAU sur le poste ou sur un emplacement réseau : supposons qu'il est dans Progs/ro/CPAU (s'il n'y est pas tu peux le récupérer dans le dossier netlogon .

En invite de commande Windows, on crée un fichier crypté qui contient la commande à exécuter :


[sourcecode]
L:
cd ro/MovieMaker
\\se3\Progs\ro\CPAU -u adminse3 -p MotPasseAdminse3 -ex &quot;\\se3\Progs\ro\MovieMaker\droitsmm.bat&quot; -profile -file droitsmm.cpau -enc

[/sourcecode]

Le fichier <code>droits.cpau</code> doit être créé, il contient la commande permettant d'exécuter le .bat en tant qu'adminse3, le tout crypté pour que le mot de passe n'apparaisse pas en clair.

Dans le template de base, on exécute ce fichier en ajoutant la ligne :

<code>\\se3\Progs\ro\CPAU -file "\\se3\Progs\ro\MovieMaker\droitsmm.cpau" -dec -profile</code>