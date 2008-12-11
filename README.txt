= scruffy

* scruffy.rubyforge.org

Author:: Brasten Sager (brasten@nagilum.com)
Date:: July 8, 2008

== DESCRIPTION:

Scruffy is a Ruby library for generating high quality, good looking graphs.  It is designed
to be easy to use and highly customizable.

For basic usage instructions, refer to the documentation for Scruffy::Graph.

== FEATURES

* Renders to SVG or bitmap (PNG, JPG)

== PROBLEMS:

* 0.2.3 version has missing legend text when rendering to bitmap. This is strange because the text is there in the SVG before it goes to RMagick.

== SYNOPSIS:

    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "line_test.svg"
    graph.render  :width => 300, :height => 200,
      :to => "line_test.png", :as => 'png'

== REQUIREMENTS:

* Needs RMagick and Magic installed, if you wish to render to bitmap.

== INSTALL:

* sudo gem install scruffy

== LICENSE:

(The MIT License)

Copyright (c) 2008 Brasten Sager (brasten@nagilum.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.