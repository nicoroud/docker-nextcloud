---
ID: 78
post_title: Rechercher un fichier en Perl
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/rechercher-un-fichier-en-perl/
published: true
post_date: 2016-01-18 19:22:03
---
Le module File::Find permet de rechercher des fichiers en fonction de critères.

<pre class="lang:perl decode:1 " >
use File::Find;

sub wanted {
    my $file = @_;
    my $path_file = $Find::File::name;
    print &quot;$file $path_file\n&quot;;
}

find(\&amp;wanted, &quot;.&quot;);
</pre>