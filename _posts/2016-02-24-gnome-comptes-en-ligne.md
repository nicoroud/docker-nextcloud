---
ID: 211
post_title: Gnome comptes en ligne
author: nicolas
post_excerpt: ""
layout: post
permalink: https://rouni.fr/gnome-comptes-en-ligne/
published: true
post_date: 2016-02-24 20:14:38
---
Si, dans les préférences des comptes en ligne, s'affiche :  "vos identifiants ont échoués", entrez ceci dans une console ou en lançant une commande via <code>ALT-F2</code> (Exécuter)

<pre class="lang:bash decode:1 " >
/usr/lib/gnome-online-accounts/goa-daemon --replace
</pre>