require 'test/unit'
require 'scruffy'

class SimpleTheme < Scruffy::Themes::Base
  def initialize
    super({
        :background => [:white, :white],
        :marker => :black,
        :colors => %w(blue green red orange yellow purple pink),
        :stroke_color => 'white'
      })
  end
end

class GraphCreationTest < Test::Unit::TestCase
  BASE_DIR = File.dirname(__FILE__)
  WEBSITE_DIR = BASE_DIR + "/../website/images/graphs"

  def test_create_pie
    graph = Scruffy::Graph.new
    graph.title = "Favourite Snacks"
    graph.renderer = Scruffy::Renderers::Pie.new

    graph.add :pie, '', {
      'Apple' => 20,
      'Banana' => 100,
      'Orange' => 70,
      'Taco' => 30
    }

    graph.render :to => "#{WEBSITE_DIR}/pie_test.svg"
    graph.render :width => 400, :to => "#{WEBSITE_DIR}/pie_test.png", :as => 'png'
  end
  
  def test_create_line
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "#{WEBSITE_DIR}/line_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/line_test.png", :as => 'png'
  end

  
  def test_create_bar
    graph = Scruffy::Graph.new
    graph.title = "Sample Bar Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.add :bar, 'Example', [20, 100, 70, 30, 106]
    graph.render :to => "#{WEBSITE_DIR}/bar_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/bar_test.png", :as => 'png'
  end
  
  def test_split
    graph = Scruffy::Graph.new
    graph.title = "Long-term Comparisons"
    graph.value_formatter = Scruffy::Formatters::Currency.new(:special_negatives => true, :negative_color => '#ff7777')
    graph.renderer = Scruffy::Renderers::Split.new(:split_label => 'Northeastern (Top) / Central (Bottom)')

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106, 203, 100, 50, 203, 289, 20], :category => :top    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26, 30, 106, 203, 100, 50, 39], :category => :top
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203, 70, 20, 102, 201, 26, 130], :category => :bottom
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70, -10, -20, 50, 92, -21, 19], :categories => [:top, :bottom]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56, 92, 84, 82, 100, 39, 120], :categories => [:top, :bottom]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    
    graph.render :to => "#{WEBSITE_DIR}/split_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/split_test.png", :as => 'png'
  end
  
  def test_stacking
    graph = Scruffy::Graph.new
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :stacked do |stacked|
      stacked.add :bar, 'Jack', [30, 60, 49, 29, 100, 120]
      stacked.add :bar, 'Jill', [120, 240, 0, 100, 140, 20]
      stacked.add :bar, 'Hill', [10, 10, 90, 20, 40, 10]
    end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/stacking_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/stacking_test.png", :as => 'png'
  end
  
  def test_multi_layered
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Cubed.new

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106], :categories => [:top_left, :bottom_right]    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26], :categories => [:bottom_left, :buttom_right]
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203], :categories => [:bottom_left, :top_right]
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70], :categories => [:top_right, :bottom_left]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56], :categories => [:top_left, :bottom_right]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/multi_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/multi_test.png", :as => 'png'
  end
end
