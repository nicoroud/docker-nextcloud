---
ID: 81
post_title: Lire une touche clavier
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/lire-une-touche-clavier/
published: true
post_date: 2016-01-18 19:26:52
---
Lire une touche clavier sous Perl.

Méthode la plus utilisée et la plus rapide :

<pre class="lang:perl decode:1 " >

chomp($saisie = &lt;STDIN&gt;);

</pre>