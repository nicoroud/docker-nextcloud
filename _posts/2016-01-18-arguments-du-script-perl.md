---
ID: 71
post_title: Arguments du script perl
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/arguments-du-script-perl/
published: true
post_date: 2016-01-18 19:07:24
---
Comment passer des arguments en ligne de commande à un script Perl.

<pre class="lang:perl decode:1 " >
 
#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my ( $fichier_in, $fichier_out ) = ();
GetOptions( 'in=s' =&gt; \$fichier_in, 'out=s' =&gt; \$fichier_out, );

unless ( defined $fichier_in and defined $fichier_out ) {
  print &quot;USAGE : $0 -in fichier_entree -out fichier_sorti\n&quot;;
}

print &quot;entree : $fichier_in\n&quot;;
print &quot;Sorti : $fichier_out\n&quot;;
 
</pre>