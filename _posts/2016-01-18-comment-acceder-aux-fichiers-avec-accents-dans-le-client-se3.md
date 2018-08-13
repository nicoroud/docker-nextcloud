---
ID: 52
post_title: >
  Comment accéder aux fichiers avec
  accents dans le client SE3 ?
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/comment-acceder-aux-fichiers-avec-accents-dans-le-client-se3/
published: true
post_date: 2016-01-18 18:39:42
---
Ajouter la ligne : <code>setlocale(LC_CTYPE, "fr_FR")</code>; dans le code du script smbwebclient.php, par exemple après la ligne $SMBWEBCLIENT_VERSION = '2.9'; ce qui donne :


<pre class="lang:php decode:1 " >

$SMBWEBCLIENT_VERSION = '2.9'; setlocale(LC_CTYPE, &quot;fr_FR&quot;);

</pre>