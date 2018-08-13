---
ID: 26
post_title: >
  Créer un fichier ou un dossier
  temporaire en bash
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/creer-un-fichier-ou-un-dossier-temporaire-en-bash/
published: true
post_date: 2016-01-18 16:12:53
---
La commande mktemp peut être utilisée pour créer des fichiers ou des répertoires uniques uniques à l’aide d’un nom de fichier base et une extension randomisée
La commande mktemp seule crée un fichier temporaire dans /tmp de la forme /tmp/tmp.xxxxxxxx

<pre class="lang:bash decode:1 " >
$
$ mktemp /tmp/tmp.zgMn7OXZkB
$
</pre>

Pour donner un suffixe au nom de fichier :

<pre class="lang:bash decode:1 " >
$ mktemp filename.XXXX
$ filename.zYQX
</pre>

Pour créer un fichier temporaire dans un autre répertoire, on utilise :

<pre class="lang:bash decode:1 " >
$ mktemp -d --tmpdir=/repertoire/
$ /repertoire/tmp.zgMn7OXZkB
</pre>