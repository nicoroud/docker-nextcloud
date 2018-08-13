---
ID: 56
post_title: WPKG et charge CPU
author: nicolas
post_excerpt: ""
layout: post
permalink: https://rouni.fr/wpkg-et-charge-cpu/
published: true
post_date: 2016-01-18 18:56:26
---
Le problème vient du test du CPU du serveur qui est fait dans le script wpkg-client.vbs qui se trouve dans le dossier "Windows".

Ce problème existe même lorsque le CPU n'est presque pas sollicité.

En mettant en commentaire les lignes suivantes qui se trouvent dans le script en question, les applications commencent à s'installer parfaitement. (Ne pas oublier de redémarrer le poste après cette modification)

[sourcecode]
' If Not TestCpuLoad() Then

' MsgErrRun=&quot;La charge cpu est trop élevée. Pas d'exécution de wpkg&quot;

' nowpkg=true

' Codesortie=14

''!WScript.Quit 14

' End If

[/sourcecode]

Attention : la ligne 35 <code>'WScript.Quit 14</code> comporte déjà un commentaire. C'est pour cela qu'il faut en ajouter un deuxième pour ne pas enlever celui qui existe déjà lorsqu'on veut remettre les lignes comme à l'origine.