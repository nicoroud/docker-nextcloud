---
ID: 246
post_title: 'Sauvegarde et restauration d&#8217;une carte SD'
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/sauvegarder-une-carte-sd/
published: true
post_date: 2016-10-21 08:18:15
---
On commence par repérer le périphérique correspondant à la carte SD à sauvegarder sur son système (/dev/sdX) :
<pre class="lang:bash decode:1 ">[~] $ fdisk -l
Disque /dev/sda : 698,7 GiB, 750156374016 octets, 1465149168 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 4096 octets
taille d'E/S (minimale / optimale) : 4096 octets / 4096 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0x44c4c1ee

Périphérique Amorçage Début Fin Secteurs Taille Id Type
/dev/sda1 2048 616447 614400 300M 83 Linux
/dev/sda2 616448 17393663 16777216 8G 82 partition d'écha
/dev/sda3 17393664 122251263 104857600 50G 83 Linux
/dev/sda4 122251264 1465149167 1342897904 640,4G 83 Linux
Disque /dev/sdc : 14,5 GiB, 15523119104 octets, 30318592 secteurs
Unités : secteur de 1 × 512 = 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Type d'étiquette de disque : dos
Identifiant de disque : 0x11cbed3e

Périphérique Amorçage Début Fin Secteurs Taille Id Type
/dev/sdc1 * 2048 1050624 1048577 512M c W95 FAT32 (LBA)
/dev/sdc2 1052672 30318591 29265920 14G 83 Linux
</pre>
Ici, il s'agit du périphérique /dev/sdc
<h3>Sauvegarde</h3>
On sauvegarde l'intégralité de la carte avec :
<pre class="lang:bash decode:1 ">dd if=/dev/sdc | gzip -9 &gt; ./nom_de_l_image.img.gz
</pre>
<h3>Restauration</h3>
On restaure ensuite la carte avec :
<pre class="lang:bash decode:1 ">gunzip ./nom_de_l_image.img.gz | sudo dd of=/dev/sdc
</pre>
Et voilà !

Source : <a href="http://blog.nicolargo.com/2013/04/raspberry-pi-faire-un-backup-de-sa-carte-sd.html" target="_blank" rel="noopener">http://blog.nicolargo.com/2013/04/raspberry-pi-faire-un-backup-de-sa-carte-sd.html</a>