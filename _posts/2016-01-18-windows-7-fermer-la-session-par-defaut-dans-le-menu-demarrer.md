---
ID: 38
post_title: 'Windows 7 : &#8220;Fermer la session&#8221; par défaut dans le menu démarrer'
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/windows-7-fermer-la-session-par-defaut-dans-le-menu-demarrer/
published: true
post_date: 2016-01-18 18:17:50
---
Clef de registre :

[sourcecode]
HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Policies/Explorer
[/sourcecode]

Vérifier que la valeur NoClose est présente.

&nbsp;

Clé : HKCU \Software \Microsoft \Windows \CurrentVersion \Policies \Explorer
Entrée : NoClose (Explorer)
Système : 95, 95+IE4.x, 98, ME, NT, 2K
Signification : Empêche d'arrêter le système
Type : REG_DWORD
Valeurs possibles : 0 ou 1
Valeur par défaut : 01 : Désactive la commande Arrêter du Menu Démarrer et de la boîte de dialogue Arrêter, mais pas de la boîte dialogue de sécurité qui apparaît sous Windows NT quand on appuie surCtrl+Alt+Suppr.