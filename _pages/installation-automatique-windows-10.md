---
ID: 433
post_title: Installation automatique Windows 10
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/se3/installation-automatique-windows-10/
published: true
post_date: 2017-12-05 20:32:12
---
<h4>Introduction</h4>
<strong>LES POSTES DOIVENT ÊTRE EN MODE BIOS LEGACY, AVEC BOOT PXE ET WAKEONLAN ACTIVÉ !</strong>

En installant les W10 en automatique avec le module se3, toutes les opérations de mise au domaine, clonage, sont automatiques et fonctionnent à tous les coups, y compris à distance et sur des hardware différents !

Prenez 30 minutes chrono à préparer une image de boot W10 avec les bons drivers, et ensuite c'est bon...
<h4><strong>Déroulé des opérations</strong></h4>
<ol>
 	<li>Téléchargement W10 officiel avec l'outil Microsoft (<a href="http://go.microsoft.com/fwlink/?LinkId=691209" target="_blank" rel="noopener">http://go.microsoft.com/fwlink/?LinkId=691209</a>)</li>
 	<li>Copie des ficihers de l'iso</li>
 	<li>Mise en place des drivers</li>
 	<li>Installation w10 en pxe avec mise au domaine et wpkg enchainé</li>
 	<li>Installation manuelle des logiciels supplémentaires sur le master</li>
 	<li>Clonage en automatique avec sysprep et retour au domaine</li>
</ol>
Si vous avez besoin de partitionner différemment le disque, il y quelques lignes à changer dans <code>/var/unattend/install/os/netinst/unattend.xml</code>, c'est parfaitement documenté chez Microsoft : <a href="https://technet.microsoft.com/fr-fr/library/dd744365(v=ws.10).aspx" target="_blank" rel="noopener noreferrer">https://technet.microsoft.com/fr-fr/library/dd744365(v=ws.10).aspx</a>
<h2>1. Préparation de l'image Windows d'installation</h2>
<h3>Téléchargement et injection des pilotes</h3>
Depuis un poste Windows 10, télécharger l'iso Windows 10 avec l'assistant de création d'iso et la copier sur z:\os\iso. Lancer (<del>depuis l'interface se3 le script de configuration <em>TODO</em>, ou</del>) en terminal :
<pre><code>install-win-iso.sh nom_de_iso.iso</code></pre>
Une fois l'arborescence de l'iso copiée sur le partage du se3, l'ajout de drivers à l'image se fait depuis un poste W10 64Bits. Aucun outil n'est nécessaire. On ajoute uniquement les drivers indispensables pour l'installation (controleurs disques et réseau).

<strong>Attention</strong> ceci doit être fait avec un compte admin du se3 (il faut avoir les droits d'écriture sur install). Le compte adminse3 ne fonctionne pas !
<h4><a id="user-content-1-recherche-de-lindex-du-winpe" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#1-recherche-de-lindex-du-winpe" aria-hidden="true"></a>1.1. recherche de l'index du winpe</h4>
<pre><code>Dism /Get-ImageInfo /ImageFile:z:\os\Win10\sources\boot.wim
</code></pre>
<pre class=""><code>Outil Gestion et maintenance des images de déploiement
Version : 10.0.15063.0
Détails pour l’image : z:\os\Win10\sources\boot.wim
Index : 1
Nom : Microsoft Windows PE (x64)
Description : Microsoft Windows PE (x64)
Taille : 1 680 843 005 octets
Index : 2
Nom : Microsoft Windows Setup (x64)
Description : Microsoft Windows Setup (x64)
Taille : 1 821 696 047 octets
</code></pre>
Dans ce cas deux indexes, si on fait une installation, seul WinPE est indispensable. On choisit donc l'index 1
<h4><a id="user-content-2-montage-de-limage" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#2-montage-de-limage" aria-hidden="true"></a>1.2. montage de l'image</h4>
<pre><code>md %temp%\wim
Dism /Mount-Image /ImageFile:z:\os\Win10\sources\boot.wim /index:1 /MountDir:%temp%\wim
</code></pre>
<h4>1.3. liste des drivers</h4>
<pre><code>Dism /image:%temp%\wim /get-drivers
</code></pre>
<h4><a id="user-content-4-ajout-de-drivers" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#4-ajout-de-drivers" aria-hidden="true"></a>4 ajout de drivers</h4>
<pre class="">Dism /image:%temp%\wim /Add-Driver /Driver:c:\drivers /Recurse</pre>
attention le chemin indiqué ne doit contenir que les drivers nécessaires sinon l'image va grossir très vite. Indiquer juste le dossier 64 bits contenant le .inf ! Répéter l'opération pour tous les drivers utiles (en général Intel et Realtek).
<h4><a id="user-content-5-démontage-de-limage" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#5-démontage-de-limage" aria-hidden="true"></a>5 Démontage de l'image</h4>
<pre><code>Dism /Unmount-Image /MountDir:%temp%\wim /Commit
</code></pre>
Normalement il n'est pas utile de répéter les opérations pour l'index 2 pour les drivers que vous voulez avoir en phase 2 (windows setup), et donc dans l'installation finale.

Vu que le réseau est accessible ensuite on peut aussi passer directement des drivers depuis un partage réseau en utilisant unattended.xml, ce qui évite de charger l'image wim.
<h2>2. Installation automatique des clients Windows 10</h2>
<h3>2.1. Prérequis</h3>
<ul>
 	<li>sources d'installation Windows installées dans z:\os\Win10 (Cf. partie 1.)</li>
 	<li>pilotes reseau et disques injectés dans l'image wim (Cf. partie 1.)</li>
 	<li>postes provisionnés dans l'annuaire: le triplet <code>nom;ip;mac</code> est renseigné et la machine appartient à un parc.</li>
 	<li>BIOS configurés pour booter en PXE (pas d'UEFI)</li>
</ul>
<em>Si le poste n'a pas d'ip réservée, l'installation se fera avec le dernier nom connu.</em>
<h3>2.2. Installation</h3>
Installation en mode <code>Legacy Bios</code>. <strong>Surtout pas d'<code>UEFI</code> !</strong>.

<strong>le paquet sambaedu-client-windows crée automatiquement la bonne structure de disque</strong>

Une seule partition <code>windows</code> + éventuellement la petite partition de boot qui est créée automatiquement par l'installeur. Pour cette partition, 100 Go sont largement suffisants.

Une astuce permet d'éviter la création de la partition de boot de 100Mo créée automatiquement à l'installation de Windows 7. Cela simplifie le clonage et la création d'images. Voici comment procéder.

<strong>Avant de lancer l'installation de Windows</strong> (par exemple avec gparted inclu dans SystemRescuCD via le boot PXE) :
<ul>
 	<li>supprimer toute partition du disque,</li>
 	<li>(re)créer une table de partition ms-dos (pas de gpt),</li>
 	<li>créer la partition destinée à recevoir l'OS (100G suffisent),</li>
 	<li>formater cette partition en NTFS.</li>
</ul>
Ainsi, lors de l'installation, en choisisant cette partition, la partition de boot de 100Mo ne sera pas créée.

Il est possible d'avoir un double-boot <code>Gnu/Linux</code>, dans ce cas <a href="https://github.com/SambaEdu/se3-docs/blob/master/pxe-clients-linux/utilisation.md#installation-en-double-boot">vous laisserez un espace vide</a> en partageant le disque dur en deux parties sensiblement égales.
<h3>2.3. Activation de Windows 10</h3>
<ul>
 	<li>si le poste a une licence éléctronique ( postes après 2012 ) la licence est automatiquement reconnue par windows 10 sans avoir besoin de rentrer de productkey. Code powershell pour lire le productkey du bios <code>pkb</code>:</li>
</ul>
<pre><code>$key=(Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductKey
</code></pre>
<ul>
 	<li>pour lire le productkey registre <code>pkr</code> on peut utiliser un script powershell ou un utilitaire pkeyui.exe</li>
 	<li>Pour les postes n'ayant pas de licence électronique dans le BIOS, la licence windows 7 de l'étiquette collée sur le poste <code>pke</code> est activable en windows 10.</li>
</ul>
<h4>Remarque importante :</h4>
Souvent les postes Windows 7 n'ont pas été activés avec le productkey de l'étiquette, mais avec une licence Volume région, ou autre. Dans ce cas la licence de l'étiquette n'est pas liée au poste, et peut être réutilisée pour n'importe quel autre poste !

En comparant le productkey du registre avec celui de l'étiquette on peut constituer un inventaire des licences consommées et libres.

Il est possible de libérer des licences, par exemple si le poste va être jeté, ou passé en client linux :
<pre><code>slmgr /dlv
</code></pre>
lire activationID...
<pre><code>slmgr /upk "activationID"
</code></pre>
Pas sûr que cel soit utile...

<em>Ceci veut dire qu'il est possible de constituer une base de <code>pke</code> libres, et de la consommer au fur et à mesure des installations, sans ce soucier de la machine d'origine</em>
<h4>procédure</h4>
<ul>
 	<li>Pour les W7 : faire l'inventaire des pk étiquettes (pke), les comparer au pk registre (pkr). Avec un petit cache en papier, on peut masquer le reste de l'étiquette et donc obtenir très simplement le pk etiquette en OCR avec une photo.</li>
 	<li>Si le <code>pke = pkr</code> la licence est bloquée, on la met dans une base avec l'@mac du poste, et on la passera à l'install de w10</li>
 	<li>si <code>pke</code> différent <code>pkr</code>, la licence est libre, on la met de côté pour les postes sans étiquette</li>
 	<li>si pas d'étiquette, on tente de récupérer la licence du bios <code>pkb</code>(poste récent). Si pas ok, on tente avec le <code>pkr</code> et sinon on prendra un <code>pke</code> W7 libre</li>
</ul>
<strong>la procédure d'activation peut se faire en fin d'installation ou de clonage. Pas besoin de compliquer la procédure d'installation !</strong>
<h4>clonage</h4>
Avec W10, l'activation resiste au sysprep et aux réinstallations successives. En revanche si on utilise un <code>pke</code>, il devient définitivement lié à la machine, il faut donc en passer un différent pour chaque poste lors du premier clonage.
<h2>3. Intégration au domaine</h2>
<strong><em>La procédure "domscripts" issue du paquet se3-domain est obsolète et ne doit plus être utilisé !</em></strong>

Il est nécessaire que le serveur <code>se3</code> soit au minimum en <strong>Wheezy 3.0.5</strong>. Le paquet <strong>sambaedu-client-windows</strong> doit être installé (sources testing pour le moment)

Une recommendation : partez d'un <code>windows10</code> de base, c'est-à-dire uniquement avec <code>windows10</code>, rien d'autre. Ou refaites une installation propre à l'aide du paquet <strong>sambaedu-client-windows</strong>, c'est automatisé et cela permet d'avoir un poste compatible à 100 % avec SambaEdu

<strong>Note</strong> : Pour le moment l'installation automatique ne permet pas de partitionner le disque avec un espace libre pour installer un <code>client-linux</code>
<h3>Intégration au domaine d'un poste déjà installé</h3>
<strong><em>Il est possible d'intégrer un poste déjà installé. Néanmoins sysprep est assez chatouilleux, et donc le succès n'est pas garanti Il faut que le poste soit à jour.</em></strong>
<ul>
 	<li>depuis l'interface se3, menu dhcp-&gt; intégrer. Attention, ne fonctionnera que si le poste a déjà l'UAC desactivée.</li>
 	<li>sur le poste, en administrateur local, connecter le lecteur <code>z:</code> à <code>\\se3\install</code> en s'identifiant en <code>adminse3</code> et lancer <code>z:\os\netinst\rejointse3.cmd</code>, ou cliquer directement sur <code>\\se3\install\os\netinst\rejointse3.cmd</code></li>
 	<li>il est possible renommer un poste déjà intégré : menu dhcp-&gt;renommer un poste windows.</li>
</ul>