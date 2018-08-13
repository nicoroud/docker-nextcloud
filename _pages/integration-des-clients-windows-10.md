---
ID: 412
post_title: Intégration des clients-windows 10
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/se3/integration-des-clients-windows-10/
published: true
post_date: 2017-12-04 22:28:53
---
Voici la procédure pour intégrer un <code class="western">windows10</code> à un domaine géré par un <code class="western">se3</code>.
<h2 class="western"><a name="user-content-prérequis"></a>Prérequis</h2>
<em>La procédure "domscripts" issue du paquet se3-domain est obsolète et ne doit plus être utilisé !</em>

Il est nécessaire que le serveur <code class="western">se3</code> soit au minimum en <strong>Wheezy 3.0.5</strong>. Le paquet <strong>sambaedu-client-windows</strong> doit être installé (sources testing pour le moment)

Une recommendation : partez d'un <code class="western">windows10</code> de base, c'est-à-dire uniquement avec <code class="western">windows10</code>, rien d'autre. Ou refaites une installation propre à l'aide du paquet <strong>sambaedu-client-windows</strong>, c'est automatisé et cela permet d'avoir un poste compatible à 100 % avec SambaEdu

Les instructions complètes sont ici : <a href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/README.md">installation windows 10</a>

<strong>note</strong> Pour le moment l'installation automatique ne permet pas de partitionner le disque avec un espace libre pour installer un <code class="western">client-linux</code>.
<h2 class="western"><a name="user-content-intégration-au-domaine-dun-poste-déjà-installé"></a> Intégration au domaine d'un poste déjà installé</h2>
<em>Il est possible d'intégrer un poste déjà installé. Néanmoins sysprep est assez chatouilleux, et donc le succès n'est pas garanti Il faut que le poste soit à jour</em>
<ul>
 	<li>depuis l'interface se3, menu dhcp-&gt; intégrer. Attention, ne fonctionnera que si le poste a déjà l'UAC desactivée.</li>
 	<li>sur le poste, en administrateur local, connecter le lecteur <code class="western">z:</code> à <code class="western">\\se3\install</code> en s'identifiant en <code class="western">adminse3</code> et lancer <code class="western">z:\os\netinst\rejointse3.cmd</code>, ou cliquer directement sur <code class="western">\\se3\install\os\netinst\rejointse3.cmd</code></li>
 	<li>il est possible renommer un poste déjà intégré : menu dhcp-&gt;renommer un poste windows.</li>
</ul>
<h2 class="western"><a name="user-content-intégration-ancienne-méthode-domscripts-obsolète-ne-pas-utiliser-pour-w10-"></a> Intégration ancienne méthode domscripts (obsolète, ne pas utiliser pour w10 !!!)</h2>
<ol>
 	<li>Ouvrir une session en administrateur local</li>
 	<li>Se connecter à \\ip_du_serveur_se3\Progs\install\domscripts ou \\se3\progs\install\domscripts avec l'identifiant "adminse3"</li>
 	<li>Fusionner <strong>Win10-Samba44.reg</strong> (clique droit sur Win10-Samba44.reg → Fusionner)
cela va ajouter les clés de registre à la base de registre et le répertoire <code class="western">netlogon</code> devient accessible comme sur un <code class="western">windows7</code></li>
</ol>
Parfois un problème de droits sur le fichier <strong>Win10-Samba44.reg</strong> empêche la fusion dans la base de registre du poste. Il faut alors le copier sur le bureau tout simplement et le fusionner depuis cet endroit.
<ol start="4">
 	<li>Exécuter <strong>rejointSE3.exe</strong>
la suite est identique à l'intégration d'un <code class="western">windows7</code></li>
</ol>
Il arrive que l'intégration bloque à une étape, il suffit de redémarrer le poste pour que la procédure continue.

<strong>Astuce :</strong> afin de pouvoir fusionner le fichier reg directement sans passer par une clé <code class="western">usb</code>, on ne se connecte pas à \\se3\netlogon\domscripts directement mais au dossier cité précedemment qui est un lien.

<strong>Astuce 2 :</strong> Il faut bien penser à <strong>désactiver la mise en veille</strong> des postes pour que l'intégration se fasse correctement.

<strong>Astuce 3 :</strong> Si le poste était auparavant intégré en W7/w10 , et que w10 a été déployé avec une image contenant les utilisateurs <em>administrateur</em> et <em>adminse3</em> , utilisateurs faisant bien partie du groupe <em>administrateur</em>,que la fusion du fichier <strong>Win10-Samba44.reg</strong> a été faite sur cette image, alors l'integration peut se faire à distance par l'interface. On va dans le <em>module DHCP</em>, <em>réservations actives</em>, puis <em>réintégrer le poste</em>.
<h2 class="western"><a name="user-content-références"></a>Références</h2>
<ul>
 	<li>recommendations pour les <a href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#pr%C3%A9requis-pour-lint%C3%A9gration-de-clients-windows">clients-windows</a>.</li>
 	<li>installation des <a href="https://github.com/SambaEdu/se3-docs/blob/master/pxe-clients-linux/README.md#installation-de-clients-linux-debian-et-ubuntu-via-se3--int%C3%A9gration-automatique">clients-linux</a>.</li>
</ul>