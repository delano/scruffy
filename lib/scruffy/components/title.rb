module Scruffy
  module Components
    class Title < Base
      def draw(svg, bounds, options={})
        if options[:title]
          svg.text(options[:title],
            :class => 'title',
            :x => (bounds[:width] / 2),
            :y => bounds[:height], 
            'font-size' => relative(100),
            'font-family' => options[:theme].font_family,
            :fill => options[:theme].marker,
            :stroke => 'none', 'stroke-width' => '0',
            'text-anchor' => (@options[:text_anchor] || 'middle'))
        end
      end
    end
  end
end