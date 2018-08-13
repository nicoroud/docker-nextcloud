---
ID: 410
post_title: sambaedu-client-windows
author: nicolas
post_excerpt: ""
layout: page
permalink: >
  https://rouni.fr/se3/sambaedu-client-windows/
published: true
post_date: 2017-12-04 22:28:05
---
Installation et mise au domaine automatique des clients windows.

Ce paquet permet l'installation totalement automatisée de Windows 10, la mise au domaine, ainsi que la préparation pré et post-clonage de Windows 7 à 10. Il remplace le paquet se3-domscripts <strong>qui ne doit plus être utilisé pour Windows 7 à 10</strong>. Ce paquet n'est conservé temporairement que pour les XP survivants.
<h2 class="western"><a name="user-content-principe"></a>Principe</h2>
Les opérations sont lancées à distance depuis l'interface SE3. Si nécessaire le nom de la machine sera demandé lors de l'installation. La configuration windows installée est optimisée pour le cas d'usage d'un domaine se3. Il est possible de la personnaliser en modifiant les fichiers .xml soit manuellement soit avec les outils Windows de configuration d'image système.
<h2 class="western"><a name="user-content-intégration-au-domaine-dun-poste-déjà-installé-7-et-10"></a> Intégration au domaine d'un poste déjà installé 7 et 10</h2>
<em>Il est possible d'intégrer un poste déjà installé. Néanmoins sysprep est assez chatouilleux, et donc le succès n'est pas garanti Il faut que le poste soit à jour</em>
<ul>
 	<li>depuis l'interface se3, menu dhcp-&gt; intégrer. Ne fonctionnera que si le poste a déjà l'UAC desactivée.</li>
 	<li>sur le poste, en administrateur, connecter le lecteur <code class="western">z:</code> à <code class="western">\\se3\install</code> et lancer <code class="western">z:\os\netinst\rejointse3.cmd</code>, ou lancer directement <code class="western">\\se3\install\os\netinst\rejointse3.cmd</code></li>
 	<li>il est possible renommer un poste déjà intégré : menu dhcp-&gt;renommer un poste windows.</li>
</ul>
<h2 class="western"><a name="user-content-prérequis-pour-une-installation-totalement-automatique-10"></a> prérequis pour une installation totalement automatique 10</h2>
<ul>
 	<li>sources d'installation Windows installées dans z:\os\Win10</li>
 	<li>pilotes reseau et disques injectés dans l'image wim <a href="https://rouni.fr/se3/preparation-de-limage-windows-dinstallation/">https://rouni.fr/se3/preparation-de-limage-windows-dinstallation/</a></li>
 	<li>postes provisionnés dans l'annuaire: le triplet nom;ip;mac est renseigné et la machine appartient à un parc.</li>
 	<li>BIOS configurés pour booter en PXE (pas d'UEFI)</li>
</ul>
<em>Si le poste n'a pas d'ip réservée, l'installation se fera avec le dernier nom connu.</em>
<h2 class="western"><a name="user-content-prérequis-pour-une-installation-manuelle"></a> prérequis pour une installation manuelle</h2>
<ul>
 	<li>sources d'installation Windows installées dans z:\os\Win10</li>
 	<li>pilotes reseau et disques injectés dans l'image wim <a href="https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md">https://github.com/SambaEdu/sambaedu-client-windows/blob/master/preparation_image.md</a></li>
 	<li>BIOS configurés pour booter en PXE (pas d'UEFI)</li>
 	<li>démarrer en pxe et taper "i"</li>
</ul>
<h2 class="western"><a name="user-content-solutions-pour-le-clonage-7-et-10"></a> solutions pour le clonage 7 et 10</h2>
<ul>
 	<li>depuis l'interface clonage avec sysrescued+ntfsclone : choisir seven64, normalement cela doit fonctionner à tout les coups si l'installation initiale est faite par ce paquet !</li>
 	<li>clonezilla ou autres : non testé, mais il suffit de cloner le poste une fois qu'il a exécuté sysprep. Le retour au domaine sera automatique. Lancer <code class="western">\\se3\install\os\netinst\rejointse3.cmd</code> avant le clonage, et lancer la solution de clonage une fois que le poste est préparé.</li>
 	<li>il est possible de cloner des machines différentes, dans la mesure où l'image windows inclut les drivers réseau et disques correspondant aux différents hardwares</li>
</ul>
<h2 class="western"><a name="user-content-a-faire"></a>A faire</h2>
<ul>
 	<li><strong>Attention, pour le moment le paquet installe Windows sur tout le disque, en ecrasant tout !</strong> Il faudrait prévoir une page dans l'interface pour pouvoir définir un partitionnement.</li>
 	<li>La mise au domaine et le clonage via sysprep ne fonctionne que si le poste a été correctement installé au départ. Identifier les problèmes et proposer un script de réparation préalable ?</li>
 	<li>Migrer le boot chaîné pxelinux-&gt;ipxe vers ipxe uniquement</li>
 	<li>afficher en temps réel les infos sur les opérations d'installation et de clonage en cours côté serveur</li>
 	<li>gestion des clés de licences Windows dans le cas de migrations ?</li>
 	<li>rendre la mise au domaine moins chatouilleuse.</li>
 	<li>ajouter la possibilité d'ajouter des drivers OEM</li>
</ul>