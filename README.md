JekyllCategoriesTag
===================

A Plugin that registers a liquid tag {% categories %} so you can show a list of all categories your posts have in their YAML front matter


It is designed to work in conjunction with the categories generator from Dave Perrett at http://recursive-design.com/projects/jekyll-plugins/

You can pass an optional argument that will be the syntax used to output each category item, with placeholders for the category name and a category link built from the site's configuration value from your _config.yml file as follows:

  category_dir: /categories


* The name place holder is [[name]]
* The link place holder is [[link]]


Examples of use:

Print a comma separated string of all categories names

  {% categories %}


Print an unordered list of categories links.

  <ul>{% categories <li><a href="[[link]]">[[name]]</a></li> %}</ul>


Please note that the list will be alphabetically ordered anyway, the html output is up to you.


Author
======

Mathieu Davy :: hello@ekynoxe.com :: [@ekynoxe](http://twitter.com/ekynoxe)


Copyright
=========

Copyright (c) 2014 Mathieu Davy. See [Licence](https://github.com/ekynoxe/JekyllCategoriesTag/blob/master/LICENCE) for details.