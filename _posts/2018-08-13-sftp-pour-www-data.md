---
ID: 604
post_title: Sftp pour www-data
author: nicolas
post_excerpt: ""
layout: post
permalink: https://rouni.fr/sftp-pour-www-data/
published: true
post_date: 2018-08-13 14:25:11
---
<h2>1. config</h2>
<ul>
 	<li>On fait une sauvegarde du fichier /etc/passwd</li>
</ul>
<pre><code class="shell">cp /etc/passwd /etc/passwd.`date +%Y%m%d`
</code></pre>
<ul>
 	<li>on édite le fichier</li>
</ul>
<pre><code class="shell">nano /etc/passwd
...
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
...
</code></pre>
On modifie cette ligne pour donner un shell à l'utilisateur www-data :
<pre><code class="shell">www-data:x:33:33:www-data:/var/www:/bin/bash
</code></pre>
On vérifie :
<pre><code class="shell">getent passwd www-data
</code></pre>
<h2>2. connexions par clé</h2>
La config de ssh n'autorisant que les connexions par clé (<code>PasswordAuthentication no</code> et <code>PermitEmptyPasswords no</code>), on copie le <code>authorized_keys</code> d'un utilisateur de confiance (moi)
<pre><code class="shell">mkdir /var/www/.ssh
cp /home/user/.ssh/authorized_keys /var/www/.ssh/
chown -R www-data:www-data /var/www/.ssh/
chmod 700 /var/www/.ssh/
chmod 600 /var/www/.ssh/authorized_keys
</code></pre>
On teste une connexion :
<pre><code class="shell">ssh www-data@exemple.fr
www-data@exemple.fr:~$
</code></pre>
<h4>Sources :</h4>
https://www.atulhost.com/www-data-sftp-user-setup
https://serverfault.com/questions/260756/allow-scp-ssh-for-www-data-user