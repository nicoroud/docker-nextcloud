---
ID: 22
post_title: 'Archlinux : Libroffice 5 crash en sauvegardant ou en exportant en pdf'
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/archlinux-libroffice-5-crash-en-sauvegardant-ou-en-exportant-en-pdf/
published: true
post_date: 2016-01-16 22:23:29
---
I can confirm that it works with GTK2, by adding SAL_USE_VCLPLUGIN=gtk lowriter to the bashrc and source it.
It crashes only with GTK3