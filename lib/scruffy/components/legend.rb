module Scruffy::Components

  class Legend < Base
    FONT_SIZE = 80
    
    def draw(svg, bounds, options={})
      vertical = options[:vertical_legend]
      legend_info = relevant_legend_info(options[:layers])
      @line_height, x, y, size = 0
      if vertical
        set_line_height = 0.08 * bounds[:height]
        @line_height = bounds[:height] / legend_info.length
        @line_height = set_line_height if @line_height >
          set_line_height
      else
        set_line_height = 0.90 * bounds[:height]
        @line_height = set_line_height
      end

      text_height = @line_height * FONT_SIZE / 100
      # #TODO how does this related to @points?
      active_width, points = layout(legend_info, vertical)

      offset = (bounds[:width] - active_width) / 2    # Nudge over a bit for true centering

      # Render Legend
      points.each_with_index do |point, idx|
        if vertical
          x = 0
          y = point
          size = @line_height * 0.5
        else
          x = offset + point
          y = 0
          size = relative(50)
        end
        
        # "#{x} #{y} #{@line_height} #{size}"
        
        svg.rect(:x => x, 
          :y => y, 
          :width => size, 
          :height => size,
          :fill => legend_info[idx][:color])

        svg.text(legend_info[idx][:title], 
          :x => x + @line_height, 
          :y => y + text_height * 0.75,
          'font-size' => text_height, 
          'font-family' => options[:theme].font_family,
          :style => "color: #{options[:theme].marker || 'white'}",
          :fill => (options[:theme].marker || 'white'))
      end
    end   # draw
    
    protected
    # Collects Legend Info from the provided Layers.
    # 
    # Automatically filters by legend's categories.
    def relevant_legend_info(layers, categories=(@options[:category] ? [@options[:category]] : @options[:categories]))
      legend_info = layers.inject([]) do |arr, layer|
        if categories.nil? ||
            (categories.include?(layer.options[:category]) ||
              (layer.options[:categories] && (categories & layer.options[:categories]).size > 0) )

          data = layer.legend_data
          arr << data if data.is_a?(Hash)
          arr = arr + data if data.is_a?(Array)
        end
        arr
      end
    end   # relevant_legend_info
      
    # Returns an array consisting of the total width needed by the legend
    # information, as well as an array of @x-coords for each element. If
    # vertical, then these are @y-coords, and @x is 0
    # 
    # ie: [200, [0, 50, 100, 150]]
    def layout(legend_info_array, vertical = false)
      if vertical
        longest = 0
        legend_info_array.each {|elem|
          cur_length = relative(50) * elem[:title].length
          longest = longest < cur_length ? cur_length : longest
        }
        y_positions = []
        (0..legend_info_array.length - 1).each {|y|
          y_positions << y * @line_height
        }
        [longest, y_positions]
      else
        legend_info_array.inject([0, []]) do |enum, elem|
          enum[0] += (relative(50) * 2) if enum.first != 0      # Add spacer between elements
          enum[1] << enum.first                                 # Add location to points
          enum[0] += relative(50)                               # Add room for color box
          enum[0] += (relative(50) * elem[:title].length)       # Add room for text

          [enum.first, enum.last]
        end        
      end
    end

  end   # class Legend
  
end   # Scruffy::Components