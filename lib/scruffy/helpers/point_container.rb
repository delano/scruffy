module Scruffy::Helpers
  
  # ==Scruffy::Helpers::PointContainer
  #
  # Author:: Mat Schaffer
  # Date:: March 22nd, 2007
  #
  # Allows all standard point operations to be called on both Array and Hash
  module PointContainer
    def self.extended point_set
      point_set.extend(const_get(point_set.class.to_s))
    end

    def sortable_values
      values.find_all { |v| v.respond_to? :<=> }
    end
    
    def summable_values
      values.find_all { |v| v.respond_to? :+ }
    end
    
    def maximum_value
      sortable_values.sort.last
    end
    
    def minimum_value
      sortable_values.sort.first
    end
    
    def sum
      summable_values.inject(0) { |sum, i| sum += i }
    end
    
    def inject_with_index memo
      index = 0
      inject(memo) do |memo, item|
        ret = yield memo, item, index
        index = index.succ
        ret
      end
    end
    
    module Array
      def values
        self
      end
    end
    
    module Hash
      def minimum_key
        self.keys.sort.first
      end
      
      def maximum_key
        self.keys.sort.last
      end
      
      def inject memo
        (minimum_key..maximum_key).each do |i|
          memo = yield memo, self[i]
        end
        memo
      end
      
      def size
        maximum_key - minimum_key + 1
      end
    end
  end
end