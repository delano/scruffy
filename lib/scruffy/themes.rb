# ===Scruffy Themes
#
# Author:: Brasten Sager & A.J. Ostman
# Date:: August 27th, 2006
#
# Scruffy Themes allow you to alter the colors and appearances of
# your graph.
module Scruffy::Themes
  
  # ==Scruffy::Themes::Base
  #
  # Author:: Brasten Sager & A.J. Ostman
  # Date:: August 27th, 2006
  #
  # The base theme class.  Most themes can be constructed simply
  # by instantiating a new Base object with a hash of color values.
  #
  # See Scruffy::Themes::Base#instantiate for examples.
  class Base
    attr_accessor :background     # Background color or array of two colors
    attr_accessor :colors         # Array of colors for data graphs
    attr_accessor :marker         # Marker color for grid lines, values, etc.
    attr_accessor :font_family    # Font family: Not really supported.  Maybe in the future.

    # Returns a new Scruffy::Themes::Base object.
    #
    # Hash options:
    # background:: background color.
    # colors:: an array of color values to use for graphs.
    # marker:: color used for grid lines, values, data points, etc.
    # font_family:: in general, allows you to change the font used in the graph.
    #               This is not yet supported in most graph elements, 
    #               and may be deprecated soon anyway.
    def initialize(descriptor)
      self.background = descriptor[:background]
      self.colors     = descriptor[:colors]
      self.marker     = descriptor[:marker]
      self.font_family = descriptor[:font_family]
    end
    
    # Returns the next available color in the color array.
    def next_color
      @previous_color = 0 if @previous_color.nil?
      @previous_color += 1
              
      self.colors[(@previous_color-1) % self.colors.size]
    end

    # todo: Implement darken function.
    def darken(color, shift=20); end
    
    # todo: Implement lighten function.
    def lighten(color, shift=20); end
    
  end
  

  
  # A basic default theme
  # Based on http://www.wellstyled.com/tools/colorscheme2/index-en.html?tetrad;50;0;255;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;1;-1;1;-0.6;0.1;1;0.6;1;0
  class Standard < Base
    def initialize
      super({
              :background => ['#FFFFFF', '#FFFFFF'],
              :marker => '#999999',
              :colors => %w(#1919B3 #FFB200 #FFFF00 #660099 #E9E9FF #FFF7E6 #FFFFE6 #F7E6FF #0F0F6B #996B00 #999900 #3D005C)
            })
    
    end
  end
  
  # Keynote theme, based on Apple's Keynote presentation software.
  #
  # Color values used from Gruff's default theme.
  class Keynote < Base
    def initialize
      super({  
              :background => [:black, '#4A465A'],
              :marker => :white, 
              :colors => %w(#6886B4 #FDD84E #72AE6E #D1695E #8A6EAF #EFAA43 white)
             })
    end
  end

  # Roughly, roughly based on the color scheme of www.mephistoblog.com.
  class Mephisto < Base
    def initialize
      super({
              :background => ['#101010', '#999977'],
              :marker => :white,
              :colors => %w(#DD3300 #66AABB #225533 #992200)
            })
      
    end
  end
  
  # Based on the color scheme used by almost every Ruby blogger.
  class RubyBlog < Base
    def initialize
      super({
              :background => ['#670A0A', '#831515'],
              :marker => '#DBD1C1',
              :colors => %w(#007777 #444477 #994444 #77FFBB #D75A20)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Apples < Base
    def initialize
      super({
              :background => ['#3B411F', '#4A465A'],
              :marker => '#DBD1C1',
              :colors => %w(#AA3322 #DD3322 #DD6644 #FFEE88 #BBCC66 #779933)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/  
  class CareBears < Base
    def initialize
      super({
              # Playing with Sky Background
              # :background => ['#2774B6', '#5EA6D8'],
              # :marker => :white,
              :background => [:black, '#4A465A'],
              :marker => :white,
              :colors => %w(#FFBBBB #00CC33 #7788BB #EEAA44 #FFDD11 #44BBDD #DD6677)
            })
    end
  end  
  
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Vitamins < Base
    def initialize
      super({
              :background => [:black, '#4A465A'],
              :marker => :white,
              :colors => %w(#CC9933 #FFCC66 #CCCC99 #CCCC33 #99CC33 #3333CC #336699 #6633CC #9999CC #333366)
            })
    end
  end
  
  # Inspired by http://www.colorschemer.com/schemes/
  class Tulips < Base
    def initialize
      super({
              :background => ['#670A0A', '#831515'],
              :marker => '#DBD1C1',
              :colors => %w(#F2C8CA #BF545E #D2808E #97985C #B3B878 #A24550)
            })
    end
  end
  
end