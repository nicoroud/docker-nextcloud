---
ID: 383
post_title: 'Prérequis pour l&#8217;intégration de <code>clients-windows</code>'
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/se3/prerequis-pour-lintegration-de-clients-windows/
published: true
post_date: 2017-12-04 21:25:18
---


<p>Ceci correspond aux configurations testées et validées pour l'intégration de postes <code>Windows</code> à un domaine <code>SE3</code>. Vu l'infinité de situations possibles, seules ces configurations sont supportées et feront l'objet d'une assistance.
* <a href="#prerequis">Prérequis</a>
* <a href="#système">Système</a>
* <a href="#installation">Installation</a>
* <a href="#ordre-de-boot">Ordre de boot</a>
* <a href="#drivers">Drivers</a>
* <a href="#licence-et-activation">Licence et activation</a>
* <a href="#antivirus-trend">Antivirus Trend</a>
* <a href="#préparation-et-mise-à-jour">Préparation et mise à jour</a>
* <a href="#logiciels">Logiciels</a>
* <a href="#outils">Outils</a></p>

<p>Pour l'intégration au domaine voir https://github.com/SambaEdu/sambaedu-client-windows/blob/master/README.md</p>

<p>Voici la procédure pour intégrer un <code>windows10</code> à un domaine géré par un <code>se3</code>.</p>

<h2>Prérequis</h2>

<p>Il est nécessaire que le serveur <code>se3</code> soit au minimum en <strong>Wheezy 3.0.5</strong>. Le paquet <strong>sambaedu-client-windows</strong> doit être installé. Ce paquet s'installe</p>

<p>Une recommendation : partez d'un <code>windows10</code> de base, c'est-à-dire uniquement avec <code>windows10</code> (version actuelle 1709), rien d'autre. Ou refaites une installation propre à l'aide du paquet <strong>sambaedu-client-windows</strong>, c'est automatisé et cela permet d'avoir un poste compatible à 100 % avec SambaEdu.</p>

<p>Les instructions complètes sont ici  :
<a href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/README.md#sambaedu-client-windows">installation windows 10</a></p>

<h2>Système</h2>

<p>Il faut impérativement partir d'un poste fraîchement installé. Le temps perdu à refaire une installation propre sera toujours du temps qu'on ne perdra pas ensuite à résoudre des incompatibilités.</p>

<ul>
<li><strong><code>Windows10</code> Pro 64 bits</strong><br />
L'image peut être téléchargé directement chez <code>Microsoft</code> sans restrictions particulières, et installée automatiquement à l'aide du paquet <code>sambaedu-client-windows</code>.
https://github.com/SambaEdu/sambaedu-client-windows/blob/master/README.md</li>
</ul>

<p><strong>Attention !!</strong> <em>En aucun cas l'ancienne méthode <code>netlogondomscriptsrejointse3.exe</code> ne doit être utilisée. Elle est définitivement incompatible avecs les versions récentes de Windows 10. Même si dans un premier temps vous pouvez croire que cela fonctionne, cela va casser à la première mise à jour de Windows !</em></p>

<ul>
<li><p><strong><code>Windows7</code> Pro 32 et 64 bits</strong><br />
Il faut utiliser une version officielle sans personnalisations <code>OEM</code>, il est admis d'y ajouter les mises à jour ainsi que les drivers à l'aide d'outils tiers : voir
<a href="#outils">les outils</a> plus bas. En revanche aucune personnalistion de type <code>GPO</code> ne doit avoir été faite.
En pratique, pour avoir un système à jour il faut déployer des milliers de mises à jour. C'est très lent ! Il vaut mieux installer W10 !</p></li>
<li><p><strong><code>WindowsXP</code> n'est plus supporté</strong>, ni par <code>SE3</code>, ni par <code>Microsoft</code>, ni par les applications récentes.<br />
Si vous vous posez la question d'installer des postes <code>windowsXP</code>, <a href="../pxe-clients-linux/README.md#installation-de-clients-linux-debian-et-ubuntu-via-se3--intégration-automatique">installez des <code>clients-linux</code></a> !</p></li>
</ul>

<h2>Installation</h2>

<p>Installation en mode <code>Legacy Bios</code>. <strong>Surtout pas d'<code>UEFI</code> !</strong>.</p>

<p><strong>le paquet sambaedu-client-windows crée automatiquement la bonne structure de disque</strong></p>

<p>Une seule partition <code>windows</code> + éventuellement la petite partition de boot qui est créée automatiquement par l'installeur. Pour cette partition, 100 Go sont largement suffisants.</p>

<h3>remarque pour Windows 7 uniquement (obsolète)</h3>

<p>Une astuce permet d'éviter la création de la partition de boot de 100Mo créée automatiquement à l'installation de Windows 7. Cela simplifie le clonage et la création d'images. Voici comment procéder.</p>

<p><strong>Avant de lancer l'installation de Windows</strong> (par exemple avec gparted inclu dans SystemRescuCD via le boot PXE) :
* supprimer toute partition du disque,
* (re)créer une table de partition ms-dos (pas de gpt),
* créer la partition destinnée à recevoir l'OS (100G suffisent),
* formater cette partition en NTFS.</p>

<p>Ainsi, lors de l'installation, en choisisannt cette partition, la partition de boot de 100Mo ne sera pas créée.</p>

<h2>double boot</h2>

<p>Il est possible d'avoir un double-boot <code>Gnu/Linux</code>, dans ce cas <a href="../pxe-clients-linux/utilisation.md#installation-en-double-boot">vous laisserez un espace vide</a> en partageant le disque dur en deux parties sensiblement égales.</p>

<h2>Ordre de boot</h2>

<p>Boot <code>PXE</code> activé (soit systématiquement, soit manuellement avec <code>F12</code>).</p>

<h2>Drivers</h2>

<p>Tous les drivers utiles doivent être installés et à jour : voir
<a href="#outils">les outils</a> plus bas.</p>

<h2>Licence et activation</h2>

<p>Pour <code>Windows7</code> il faut activer à l'aide d'un outil tiers…</p>

<p>Pour <code>Windows10</code>, théoriquement aucune activation n'est requise si le poste est éligible à une installation <code>OEM</code>. Ceci implique généralement que les clés OEM SLIC V2.4 soient intégrées au Bios. Ce n'est malheureusement pas toujours le cas. Il est possible de récupérer la licence du bios, l'intégration se3 le fera automatiquement en cas de besoin.
En cas d'absence d'activation, un message s'affiche en fond d'écran, mais à part cela tout fonctionne.</p>

<p><strong>Attention</strong> Ne pas télécharger et utiliser Windows Loader pour Windows 10 : c'est un faux, qui en revanche installe de vrais virus !</p>

<h2>Antivirus Trend</h2>

<p>Si l'établissement dispose d'un serveur antivirus Trend, alors celui-ci doit impérativement être à jour pour que le client puisse s'installer sur les postes Windows 10 en version 1709.</p>

<h2>Intégration au domaine et mise à jour</h2>

<p><strong>Sur un serveur à jour, AUCUNE opération manuelle n'est nécessaire pour intégrer windows 10 et 7</strong>, il faut utiliser le paquet sambaedu-client-windows.
https://github.com/SambaEdu/sambaedu-client-windows/blob/master/README.md</p>

<h2>ancienne méthode (obsolète, windows 7 uniquement !!!)</h2>

<ul>
<li>ne fonctionne pas pour les postes en w10 !</li>
<li>obsolète et non maintenue pour w7</li>
</ul>

<p>Désactiver la mise en veille pour surveiller le poste pendant son intégration l'intégration.</p>

<p>Il est possible d'automatiser un certain nombre de réglages, dans l'optique de faire une <strong>image de la machine</strong> avant l'intégration. À vous de choisir parmi les commandes suivantes, celles qui vous conviennent et les mettre dans un fichier <code>.bat</code>.</p>

<p><em>Si l'image de la machine possède déjà l'utilisateurs adminse3, et que le mdp d'adminse3 est bien donné qu compte administrateur, alors l'intégration à distance de l'image déployée pourra se faire directement par l'interface.</em></p>

<ul>
<li>Désactiver les 3 pare-feux de Windows7 :</li>
</ul>

<p><code>netsh advfirewall set allprofiles state off</code></p>

<ul>
<li>Désactiver un compte local "essai" issu de l'installation :</li>
</ul>

<p><code>net user essai /active:no</code></p>

<ul>
<li>Rendre actif le compte Administrateur :</li>
</ul>

<p><code>net user Administrateur /active:yes</code></p>

<ul>
<li>Ajouter le compte "adminse3" :</li>
</ul>

<p><code>net user /add adminse3 mdp_admise3</code></p>

<ul>
<li>Ajouter ce compte adminse3 aux administrateurs locaux :</li>
</ul>

<p><code>net localgroup Administrateurs adminse3 /add</code></p>

<ul>
<li>Donner aux mots de passe une durée de validité illimitée :</li>
</ul>

<p><code>net accounts /maxpwage:unlimited</code></p>

<ul>
<li>Désactiver le controle UAC :</li>
</ul>

<p><code>reg.exe ADD HKLMSOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystem /v EnableLUA /t REG_DWORD /d 0 /f</code></p>

<ul>
<li>Mettre à jour depuis wsusoffline du Se3 :</li>
</ul>

<p><code>net use W: \IP_du_Se3installwsusoffline mdp_admise3 /user:sambaedu3adminse3
w:clientcmdDoUpdate.cmd /updatecerts /instielatest /updatecpp /instmssl /instdotnet35 /instdotnet4 /instpsh /instofv
net use W: /delete</code>
Si par hasard les màj windows update sont bloquées, une piste de résolution <a href="http://www.easy-pc.org/2016/06/fix-windows-7-quand-les-verifications-des-mises-a-jour-prend-trop-de-temps.html">ici</a>.</p>

<h2>Logiciels</h2>

<p>Aucun logiciel installable à l'aide de <code>Wpkg</code> ne doit être installé préalablement. C'est une source de problème sans fin.</p>

<p>Partez d'une installation de <code>Windows</code> de base et laissez le serveur <code>Wpkg</code> gérer les applications à installer.</p>

<h2>Outils</h2>

<p>…à compléter…
* <a href="http://www.downflex.com/">Obtenir des ISO légalement</a>
* <a href="https://sdi-tool.org/">Pack de drivers</a>
* <a href="http://www.winsetupfromusb.com/">Créer une clé USB bootable</a>
* <a href="http://rt7lite.com/">Créer une ISO personnalisée</a>
* <a href="http://joshcellsoftwares.com/products/advancedtokensmanager/">Sauvegarder et restaurer l'activation</a> (<a href="http://www.pcastuces.com/pratique/windows/sauvegarder_activation/page1.htm">Documentation</a>)</p>