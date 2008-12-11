module Scruffy::Layers
  # ==Scruffy::Layers::PieSlice
  # 
  # Author:: A.J. Ostman
  # Date:: August 14th, 2006
  # 
  # Basic Pie Chart Slice..
    
  class PieSlice < Base
  
    # Setup Constants
    RADIANS = Math::PI / 180 
    MARKER_OFFSET_RATIO = 1.2
    MARKER_FONT_SIZE = 6
    
    attr_accessor :diameter
    attr_accessor :percent_used
    attr_accessor :degree_offset
    attr_accessor :scaler
    attr_accessor :center_x, :center_y
    
    def draw(svg, coords, options = {})
      # Scaler is the multiplier to normalize the values to a percentage across
      # the Pie Chart
      @scaler = options[:scaler] || 1
      
      # Degree Offset is degrees by which the pie chart is twisted when it
      # begins
      @degree_offset = options[:degree_offset] || @options[:degree_offset] || 0
      
      # Percent Used keeps track of where in the pie chart we are
      @percent_used = options[:percent_used] || @options[:percent_used] || 0
      
      # Diameter of the pie chart defaults to 80% of the height
      @diameter = relative(options[:diameter]) || relative(@options[:diameter]) || relative(80.0)
      
      # Stroke
      stroke = options[:stroke] || @options[:stroke] || "none"

      # Shadow
      shadow = options[:shadow] || @options[:shadow_] || false
      shadow_x = relative(options[:shadow_x]) || relative(@options[:shadow_x]) || relative(-0.5)
      shadow_y = relative(options[:shadow_y]) || relative(@options[:shadow_y]) || relative(0.5)
      shadow_color = options[:shadow_color] || @options[:shadow_color] || "white"
      shadow_opacity = options[:shadow_opacity] || @options[:shadow_opacity] || 0.06
      
      # Coordinates for the center of the pie chart.
      @center_x = relative_width(options[:center_x]) || relative_width(@options[:center_x]) || relative_width(50)
      @center_y = relative_height(options[:center_y]) || relative_height(@options[:center_y]) || relative_height(50)
      radius = @diameter / 2.0
      
      # Graphing calculated using percent of graph. We later multiply by 3.6 to
      # convert to 360 degree system.
      percent = @scaler * sum_values
      

      # Calculate the Radian Start Point
      radians_start = ((@percent_used * 3.6) + @degree_offset) * RADIANS
      # Calculate the Radian End Point
      radians_end = ((@percent_used + percent) * 3.6 + @degree_offset) * RADIANS

      radians_mid_point = radians_start + ((radians_end - radians_start) / 2)
      
      if options[:explode]
        @center_x = @center_x + (Math.sin(radians_mid_point) * relative(options[:explode]))
        @center_y = @center_y - (Math.cos(radians_mid_point) * relative(options[:explode]))
      end
  

      # Calculate the beginning coordinates
      x_start = @center_x + (Math.sin(radians_start) * radius)
      y_start = @center_y - (Math.cos(radians_start) * radius)
      
      # Calculate the End Coords
      x_end = @center_x + (Math.sin(radians_end) * radius)
      y_end = @center_y - (Math.cos(radians_end) * radius)

      

      # If percentage is really really close to 100% then draw a circle instead!
      if percent >= 99.9999
        
        if shadow
          svg.circle(:cx => "#{@center_x + shadow_x}", :cy => "#{@center_y + shadow_y}", :r=>"#{radius}",:stroke => "none", 
            :fill => shadow_color.to_s,  :style => "fill-opacity: #{shadow_opacity.to_s};")
        end
        
        svg.circle(:cx => "#{@center_x}", :cy => "#{@center_y}", :r=>"#{radius}",:stroke => stroke, :fill => color.to_s)

      else  
        if shadow
          svg.path(:d =>  "M#{@center_x + shadow_x},#{@center_y + shadow_y} L#{x_start + shadow_x},#{y_start + shadow_y} A#{radius},#{radius} 0, #{percent >= 50 ? '1' : '0'}, 1, #{x_end + shadow_x} #{y_end + shadow_y} Z", 
            :fill => shadow_color.to_s, :style => "fill-opacity: #{shadow_opacity.to_s};")
        end
        
        svg.path(:d =>  "M#{@center_x},#{@center_y} L#{x_start},#{y_start} A#{radius},#{radius} 0, #{percent >= 50 ? '1' : '0'}, 1, #{x_end} #{y_end} Z", 
          :stroke => stroke, :fill => color.to_s)
      end
      
      text_x = @center_x + (Math.sin(radians_mid_point) * radius * MARKER_OFFSET_RATIO)
      text_y = @center_y - (Math.cos(radians_mid_point) * radius * MARKER_OFFSET_RATIO)

      svg.text("#{sprintf('%d', percent)}%",
        :x => text_x,
        :y => text_y + relative(MARKER_FONT_SIZE / 2), 
        'font-size' => relative(MARKER_FONT_SIZE),
        'font-family' => options[:theme].font_family,
        :fill => (options[:theme].marker || 'black').to_s, 
        'text-anchor' => 'middle')
    end

    protected
    def generate_coordinates(options = {})
      # Coordinate Generation didn't make much sense here. Overridden just
      # because Brasten said this would be overridden.
    end
  end
  
end