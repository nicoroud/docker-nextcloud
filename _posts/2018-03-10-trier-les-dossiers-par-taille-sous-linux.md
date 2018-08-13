---
ID: 509
post_title: Trier les dossiers par taille sous Linux
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/trier-les-dossiers-par-taille-sous-linux/
published: true
post_date: 2018-03-10 11:23:13
---
Pour trier les dossiers de /home
<pre class="lang:sh decode:true ">du -sm /home/*/ | sort -nrk1 | head -20</pre>
Ici il faut deux programmes :
<ol>
 	<li><code>du</code>qui donne l'utilisation disque avec comme options :
<ul>
 	<li>-s pour faire le summarize (total) pour chaque argument</li>
 	<li>-k pour afficher toutes les tailles en ko (pour ne pas comparer 123 ko qui serait alors supérieur à 8 Mo)</li>
</ul>
</li>
 	<li><code>sort</code>qui signifie trier avec comme argument :
<ul>
 	<li>-n pour que la clé de triage soit comprise comme une valeur dechiffre car sinon le chiffre 123 est plus petit que 46 de la même manière que ABC est plus petit que DF (puisque A est plus petit que D.</li>
</ul>
</li>
</ol>
Donc:
<pre class="lang:sh decode:true ">du -sk /home/* | sort -n</pre>
&nbsp;