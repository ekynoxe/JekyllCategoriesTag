# encoding: utf-8
#
# Jekyll categories list plugin
# http://www.ekynoxe.com/
# Version: 0.0.1 (2014-01-18)
#
# Copyright (c) 2014 Mathieu Davy - ekynoxe - http://ekkynoxe.com/
# Licenced under the MIT licence
# (http://www.opensource.org/licenses/mit-license.php)
#
# This plugin registers a liquid tag {% categories %} that will output
# => a list of all categories your posts have in their YAML front matter
# It is designed to work in conjunction with the categories generator
# => from Dave Perrett at http://recursive-design.com/projects/jekyll-plugins/
#
# You can pass an optional argument that will be the syntax used to
# => output each category item, with placeholders for the category name
# => and a category link built from the site's configuration value from
# => your _config.yml file as follows:
#
#       category_dir: /categories
#
# => The name place holder is [[name]]
# => The link place holder is [[link]]
#
#
# Examples of use:
#
# Print a comma separated string of all categories names
#
#       {% categories %}
#
#
# Print an unordered list of categories links.
#
#       <ul>{% categories <li><a href="[[link]]">[[name]]</a></li> %}</ul>
#
#
# Please note that the list will be alphabetically ordered anyway,
# => the html output is up to you.

module Jekyll
  class CategoriesTag < Liquid::Tag
    safe = true

    def initialize(tag_name, text, tokens)
        super

        # Defaulting output to a comma separated list
        @syntax = "[[name]]"
        @separator = ", "

        # Override syntax and separator if provided
        if !text.empty?
            @syntax = text
            @separator = ""
        end
    end

    def render(context)
        out_list = []
        site = context.registers[:site]
        category_dir = site.config['category_dir']

        # Sorting categories
        cats = site.categories.sort do |a, b|
            a[0].nil? ? -1 : b[0].nil? ? 1 : a[0] <=> b[0]
        end

        cats.each do |cat, posts|
            cat_out = @syntax.dup

            if @syntax.include? "[[link]]" and category_dir
                category_dir = "/#{category_dir}" unless category_dir =~ /^\//
                cat_out.gsub!(/\[\[link\]\]/, "#{category_dir}/#{cat}/")
            end

            if @syntax.include? "[[name]]"
                cat_out.gsub!(/\[\[name\]\]/, cat)
            end

            out_list << cat_out
        end

        out_list.join(@separator)
    end
  end
end

Liquid::Template.register_tag('categories', Jekyll::CategoriesTag)