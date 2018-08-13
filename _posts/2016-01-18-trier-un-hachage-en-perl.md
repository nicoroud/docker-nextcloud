---
ID: 74
post_title: Trier un hachage en Perl
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/trier-un-hachage-en-perl/
published: true
post_date: 2016-01-18 19:20:10
---
Afficher un hachage trié

<pre class="lang:perl decode:1 " >

print &quot;$_ $hash{$_}\n&quot; for sort keys %hash;

</pre>

D'autres façons de trier un hachage :

<pre class="lang:perl decode:1 " >

my @ord=sort keys %hash;

for my $cle(@ord){

print &quot;$cle $hash{$cle}\n&quot;;

}

</pre>

ou

print "$_ $hash{$_}\n" for @ord;
ou
for my $cle(sort keys %hash){ print "$cle $hash{$cle}\n"; }
ou encore
foreach $cle (sort keys %HASH { print $cle, '=', $HASH{$cle}, "\n"; }