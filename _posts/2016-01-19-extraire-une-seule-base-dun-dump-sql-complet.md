---
ID: 5
post_title: >
  Extraire une seule base d’un dump SQL
  complet
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/extraire-une-seule-base-dun-dump-sql-complet/
published: true
post_date: 2016-01-19 21:19:03
---
Pour importer une seule base à partir d'un dump complet, il faut entrer la commande suivante:
<pre class="lang:mysql decode:true ">mysql -u root -p --one-database BASE-A-RESTAURER &lt;mysqldump-all-databases.sql
</pre>
&nbsp;