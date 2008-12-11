# ===GraphState
#
# Author:: Brasten Sager
# Date:: September 27th, 2007
#
# State object for holding all of the graph's
# settings.  Attempting to clean up the
# graph interface a bit.

module Scruffy
  class GraphState

    attr_accessor :title
    attr_accessor :theme
    attr_accessor :default_type
    attr_accessor :point_markers
    attr_accessor :value_formatter
    attr_accessor :rasterizer
    
    def initialize
      
    end
  end
end
