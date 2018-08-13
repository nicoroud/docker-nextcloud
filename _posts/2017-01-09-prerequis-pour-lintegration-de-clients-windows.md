---
ID: 320
post_title: 'Prérequis pour l&#8217;intégration de clients-windows'
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/prerequis-pour-lintegration-de-clients-windows/
published: true
post_date: 2017-01-09 07:17:12
---
Ceci correspond aux configurations testées et validées pour l'intégration de postes <code>Windows</code> à un domaine <code>SE3</code>. Vu l'infinité de situations possibles, seules ces configurations sont supportées et feront l'objet d'une assistance.
<h2><a id="user-content-système" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#syst%C3%A8me"></a>Système</h2>
Il faut impérativement partir d'un poste fraîchement installé. Le temps perdu à refaire une installation propre sera toujours du temps qu'on ne perdra pas ensuite à résoudre des incompatibilités.
<ul>
 	<li><strong><code>Windows10</code> Pro 64 bits</strong>
L'installeur peut être téléchargé directement chez <code>Microsoft</code> sans restrictions particulières, et installé sur une clé <code>USB</code>.</li>
 	<li><strong><code>Windows7</code> Pro 32 et 64 bits</strong>
Il faut utiliser une version officielle sans personnalisations <code>OEM</code>, il est admis d'y ajouter les mises à jour ainsi que les drivers à l'aide d'outils tiers : voir <a href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#outils">les outils</a> plus bas. En revanche aucune personnalistion de type <code>GPO</code> ne doit avoir été faite.</li>
 	<li><strong><code>WindowsXP</code> n'est plus supporté</strong>, ni par <code>SE3</code>, ni par <code>Microsoft</code>, ni par les applications récentes.
Si vous vous posez la question d'installer des postes <code>windowsXP</code>, <a href="https://github.com/SambaEdu/se3-docs/blob/master/pxe-clients-linux/README.md#installation-de-clients-linux-debian-et-ubuntu-via-se3--int%C3%A9gration-automatique">installez des <code>clients-linux</code></a> !</li>
</ul>
<h2><a id="user-content-installation" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#installation"></a>Installation</h2>
Installation en mode <code>Legacy Bios</code>. <strong>Surtout pas d'<code>UEFI</code> !</strong>.

Une seule partition <code>windows</code> + la petite partition de boot qui est créée automatiquement par l'installeur. Pour cette partition, 100 Go sont largement suffisant.

Une astuce permet d'éviter la création de la partition de boot de 100Mo créée automatiquement à l'installation de Windows 7. Cela simplifie le clonage et la création d'images. Voici comment procéder.

<strong>Avant de lancer l'installation de Windows</strong> (par exemple avec gparted inclu dans SystemRescuCD via le boot PXE) :
<ul>
 	<li>supprimer toute partition du disque,</li>
 	<li>(re)créer une table de partition ms-dos (pas de gpt),</li>
 	<li>créer la partition destinnée à recevoir l'OS (100G suffisent),</li>
 	<li>formater cette partition en NTFS.</li>
</ul>
Ainsi, lors de l'installation, en choisisannt cette partition, la partition de boot de 100Mo ne sera pas créée.

Il est possible d'avoir un double-boot <code>Gnu/Linux</code>, dans ce cas <a href="https://github.com/SambaEdu/se3-docs/blob/master/pxe-clients-linux/utilisation.md#installation-en-double-boot">vous laisserez un espace vide</a> en partageant le disque dur en deux parties sensiblement égales.
<h2><a id="user-content-ordre-de-boot" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#ordre-de-boot"></a>Ordre de boot</h2>
Boot <code>PXE</code> activé (soit systématiquement, soit manuellement avec <code>F12</code>).
<h2><a id="user-content-drivers" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#drivers"></a>Drivers</h2>
Tous les drivers utiles doivent être installés et à jour : voir <a href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#outils">les outils</a> plus bas.
<h2><a id="user-content-licence-et-activation" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#licence-et-activation"></a>Licence et activation</h2>
Pour <code>Windows7</code> il faut activer à l'aide d'un outil tiers…

Pour <code>Windows10</code>, aucune activation n'est requise si le poste est éligible à une installation <code>OEM</code>. Ceci implique généralement que les clés OEM SLIC V2.4 soient intégrées au Bios. Ce n'est malheureusement pas toujours le cas. On a alors deux possibilités légales pour éviter de devoir faire l'activation : intégrer les clés au Bios si on les possède, ou installer à partir du DVD OEM du constructeur.

<strong>Attention</strong> Ne pas télécharger et utiliser Windows Loader pour Windows 10 : c'est un faux, qui en revanche installe de vrais virus !
<h2><a id="user-content-préparation-et-mise-à-jour" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#pr%C3%A9paration-et-mise-%C3%A0-jour"></a>Préparation et mise à jour</h2>
Il est possible d'automatiser un certain nombre de réglages, dans l'optique de faire une image de la machine avant l'intégration. À vous de choisir parmi les commandes suivantes, celles qui vous conviennent et les mettre dans un fichier <code>.bat</code>.
<ul>
 	<li>Désactiver les 3 pare-feux de Windows7 :</li>
</ul>
<code>netsh advfirewall set allprofiles state off</code>
<ul>
 	<li>Désactiver un compte local "essai" issu de l'installation :</li>
</ul>
<code>net user essai /active:no</code>
<ul>
 	<li>Rendre actif le compte Administrateur :</li>
</ul>
<code>net user Administrateur /active:yes</code>
<ul>
 	<li>Ajouter le compte "adminse3" :</li>
</ul>
<code>net user /add adminse3 mdp_admise3</code>
<ul>
 	<li>Ajouter ce compte adminse3 aux administrateurs locaux :</li>
</ul>
<code>net localgroup Administrateurs adminse3 /add</code>
<ul>
 	<li>Donner aux mots de passe une durée de validité illimitée :</li>
</ul>
<code>net accounts /maxpwage:unlimited</code>
<ul>
 	<li>Désactiver le controle UAC :</li>
</ul>
<code>reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f</code>
<ul>
 	<li>Mettre à jour depuis wsusoffline du Se3 :</li>
</ul>
<pre><code>net use W: \\IP_du_Se3\install\wsusoffline mdp_admise3 /user:sambaedu3\adminse3
w:\client\cmd\DoUpdate.cmd /updatecerts /instielatest /updatecpp /instmssl /instdotnet35 /instdotnet4 /instpsh /instofv
net use W: /delete
</code></pre>
<h2><a id="user-content-logiciels" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#logiciels"></a>Logiciels</h2>
Aucun logiciel installable à l'aide de <code>Wpkg</code> ne doit être installé préalablement. C'est une source de problème sans fin.

Partez d'une installation de <code>Windows</code> de base et laissez le serveur <code>Wpkg</code> gérer les applications à installer.
<h2><a id="user-content-outils" class="anchor" href="https://github.com/SambaEdu/se3-docs/blob/master/se3-clients-windows/clients-windows.md#outils"></a>Outils</h2>
…à compléter…
<ul>
 	<li><a href="http://www.downflex.com/">Obtenir des ISO légalement</a></li>
 	<li><a href="https://sdi-tool.org/">Pack de drivers</a></li>
 	<li><a href="http://www.winsetupfromusb.com/">Créer une clé USB bootable</a></li>
 	<li><a href="http://rt7lite.com/">Créer une ISO personnalisée</a></li>
 	<li><a href="http://joshcellsoftwares.com/products/advancedtokensmanager/">Sauvegarder et restaurer l'activation</a> (<a href="http://www.pcastuces.com/pratique/windows/sauvegarder_activation/page1.htm">Documentation</a>)</li>
</ul>