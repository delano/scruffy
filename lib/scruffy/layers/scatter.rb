module Scruffy::Layers
  # ==Scruffy::Layers::Line
  #
  # Author:: Mat Schaffer
  # Date:: March 20th, 2007
  #
  # Simple scatter graph
  class Scatter < Base
    
    # Renders scatter graph.
    def draw(svg, coords, options={})
      svg.g(:class => 'shadow', :transform => "translate(#{relative(0.5)}, #{relative(0.5)})") {
        coords.each { |coord| svg.circle( :cx => coord.first, :cy => coord.last + relative(0.9), :r => relative(2), 
                                          :style => "stroke-width: #{relative(2)}; stroke: black; opacity: 0.35;" ) }
      }

      coords.each { |coord| svg.circle( :cx => coord.first, :cy => coord.last, :r => relative(2), 
                                        :style => "stroke-width: #{relative(2)}; stroke: #{color.to_s}; fill: #{color.to_s}" ) }
    end
  end
end