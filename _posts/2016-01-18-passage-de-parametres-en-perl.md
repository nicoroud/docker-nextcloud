---
ID: 76
post_title: Passage de paramètres en Perl
author: nicolas
post_excerpt: ""
layout: post
permalink: >
  https://rouni.fr/passage-de-parametres-en-perl/
published: true
post_date: 2016-01-18 19:21:22
---

Une fonction peut ne pas comporter d'arguments (paramètres formels), mais cela présente assez peu d'intérêts et peut même se révéler dangereux puisque l'on peut modifier les variables globales (variables visibles de tous les blocs d'instructions).

Les paramètres réels (transmis à l'appel de la fonction) sont stockés dans le tableau dénoté par la variable spéciale @_(qui est un tableau ou encore une liste) et sont passés aux paramètres formels désignés dans cet exemple par les variables scalaires '''$x''' et '''$y'''. Si on utilise cette syntaxe (ce qui est fortement conseillé), la transmission se fait par valeurs i.e. toutes modifications des paramètres formels n'est visible que dans le bloc (et ses sous-blocs) de définition de la fonction.

<pre class="lang:perl decode:1 " >
sub fonction {
    my ( $x, $y,...) = @_;
    return ...
}
</pre>