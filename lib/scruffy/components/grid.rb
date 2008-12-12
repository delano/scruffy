module Scruffy
  module Components
    class Grid < Base
      attr_accessor :markers
      
      def draw(svg, bounds, options={})
        markers = (options[:markers] || self.markers) || 5
        
        stroke_width = options[:stroke_width]
        
        (0...markers).each do |idx|
          marker = ((1 / (markers - 1).to_f) * idx) * bounds[:height]
          svg.line(:x1 => 0, :y1 => marker, :x2 => bounds[:width], :y2 => marker, :style => "stroke: #{options[:theme].marker.to_s}; stroke-width: #{stroke_width};")
        end
      end
    end
  end
end

