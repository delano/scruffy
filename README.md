# Scruffy, unofficial release

This is a fork from based on the official 0.2.5 release. See below for 
further a longer description.  

## Description:

* scruffy.rubyforge.org

Author:: Brasten Sager (brasten@nagilum.com)
Date:: July 8, 2008
Release:: 0.2.5

Scruffy is a Ruby library for generating high quality, good looking graphs.  It is designed
to be easy to use and highly customizable.

For basic usage instructions, refer to the documentation for Scruffy::Graph.


## Fork Description

* http://github.com/delano/scruffy/

Author:: Delano Mandelbaum (delano@solutious.com)
Author:: Kalin Harvey
Date:: December 12, 2008

We love scruffy. Our motivation for creating a forking is to make it useful for hi-resolution 
graphs and charts. We would love to get our changes in to the official release but until
that time they will be available at the GitHub URI above. 

CHANGES.txt contains everything we've been up to. 


## Features

* Renders to SVG or bitmap (PNG, JPG)

## Problems:

* 0.2.3 version has missing legend text when rendering to bitmap. This is strange because the text is there in the SVG before it goes to RMagick.

## Synopsis:

    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "line_test.svg"
    graph.render  :width => 300, :height => 200,
      :to => "line_test.png", :as => 'png'

## Requirements :

* Needs RMagick and Magic installed, if you wish to render to bitmap.

## Install:

* sudo gem install scruffy


## License:

See Licence.txt
