module Scruffy::Layers
  # ==Scruffy::Layers::Line
  #
  # Author:: Brasten Sager
  # Date:: August 7th, 2006
  #
  # Line graph.
  class Line < Base
    
    # Renders line graph.
    def draw(svg, coords, options={})
      svg.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
        svg.polyline( :points => stringify_coords(coords).join(' '), :fill => 'transparent', 
                      :stroke => 'black', 'stroke-width' => relative(2), 
                      :style => 'fill-opacity: 0; stroke-opacity: 0.35' )

        coords.each { |coord| svg.circle( :cx => coord.first, :cy => coord.last + relative(0.9), :r => relative(2), 
                                          :style => "stroke-width: #{relative(2)}; stroke: black; opacity: 0.35;" ) }
      }


      svg.polyline( :points => stringify_coords(coords).join(' '), :fill => 'none', 
                    :stroke => color.to_s, 'stroke-width' => relative(2) )

      coords.each { |coord| svg.circle( :cx => coord.first, :cy => coord.last, :r => relative(2), 
                                        :style => "stroke-width: #{relative(2)}; stroke: #{color.to_s}; fill: #{color.to_s}" ) }
    end
  end
end