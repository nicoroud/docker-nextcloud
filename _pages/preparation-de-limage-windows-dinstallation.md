---
ID: 423
post_title: 'Préparation de l&#8217;image Windows d&#8217;installation'
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/preparation-de-limage-windows-dinstallation/
published: true
post_date: 2017-12-05 10:51:31
---
<h2><a id="user-content-téléchargement" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#t%C3%A9l%C3%A9chargement" aria-hidden="true"></a>Téléchargement</h2>
Depuis un poste Windows 10, télécharger l'iso Windows 10 avec l'assistant de creation d'iso et la copier sur z:\os\iso. Lancer depuis l'interface se3 le script de configuration <em>TODO</em>, ou en terminal :
<pre><code>install-win-iso.sh nom_de_iso.iso
</code></pre>
<h2><a id="user-content-injection-des-pilotes" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#injection-des-pilotes" aria-hidden="true"></a>Injection des pilotes</h2>
Une fois l'arborescence de l'iso copiée sur le partage du se3, l'ajout de drivers à l'image se fait depuis un poste W10 64Bits. Aucun outil n'est nécessaire. On ajoute uniquement les drivers indispensables pour l'installation (controleurs disques et réseau).

<strong>Attention</strong> ceci doit être fait avec un compte admin du se3 (il faut avoir les droits d'écriture sur install). Le compte adminse3 ne fonctionne pas !
<h2><a id="user-content-1-recherche-de-lindex-du-winpe" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#1-recherche-de-lindex-du-winpe" aria-hidden="true"></a>1 recherche de l'index du winpe</h2>
<pre><code>Dism /Get-ImageInfo /ImageFile:z:\os\Win10\sources\boot.wim
</code></pre>
<pre><code>Outil Gestion et maintenance des images de déploiement
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
<h2><a id="user-content-2-montage-de-limage" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#2-montage-de-limage" aria-hidden="true"></a>2 montage de l'image</h2>
<pre><code>md %temp%\wim
Dism /Mount-Image /ImageFile:z:\os\Win10\sources\boot.wim /index:1 /MountDir:%temp%\wim
</code></pre>
<h2><a id="user-content-3-liste-des-drivers" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#3-liste-des-drivers" aria-hidden="true"></a>3 liste des drivers</h2>
<pre><code>Dism /image:%temp%\wim /get-drivers
</code></pre>
<h2><a id="user-content-4-ajout-de-drivers" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#4-ajout-de-drivers" aria-hidden="true"></a>4 ajout de drivers</h2>
<pre><code>Dism /image:%temp%\wim /Add-Driver /Driver:c:\drivers /Recurse
</code></pre>
attention le chemin indiqué ne doit contenir que les drivers nécessaires sinon l'image va grossir très vite. Indiquer juste le dossier 64 bits contenant le .inf ! Répéter l'opération pour tous les drivers utiles (en général Intel et Realtek).
<h2><a id="user-content-5-démontage-de-limage" class="anchor" href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md#5-d%C3%A9montage-de-limage" aria-hidden="true"></a>5 Démontage de l'image</h2>
<pre><code>Dism /Unmount-Image /MountDir:%temp%\wim /Commit
</code></pre>
Normalement il n'est pas utile de répéter les opérations pour l'index 2 pour les drivers que vous voulez avoir en phase 2 (windows setup), et donc dans l'installation finale.

Vu que le réseau est accessible ensuite on peut aussi passer directement des drivers depuis un partage réseau en utilisant unattended.xml, ce qui évite de charger l'image wim.