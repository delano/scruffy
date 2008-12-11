require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'scruffy'
require 'fileutils'

module CustomRenderers
  def blank_renderer
    object = Object.new
    object.instance_eval { class << self;self;end }.instance_eval { define_method :render do |options|
        puts "Rendering"
      end
    }
    object
  end
end

describe "A new Scruffy::Graph" do
  include CustomRenderers
  
  setup do
    @graph = Scruffy::Graph.new
  end
  
  it "should have a blank title" do
    @graph.title.should be_nil
  end
  
  it "should be set to the keynote theme" do
    @graph.theme.class.should equal(Scruffy::Themes::Keynote)
  end
  
  it "should have zero layers" do
    @graph.layers.should be_empty
  end
  
  it "should not have a default layer type" do
    @graph.default_type.should be_nil
  end
  
  it "should not have any point markers (x-axis values)" do
    @graph.point_markers.should be_nil
  end
  
  it "should format values as numbers by default" do
    @graph.value_formatter.should be_instance_of(Scruffy::Formatters::Number)
  end
  
  it "should use a StandardRenderer" do
    @graph.renderer.should_be be_instance_of(Scruffy::Renderers::Standard)
  end
  
  it "should accept a new title" do
    @graph.title = "New Title"
    @graph.title.should == "New Title"
  end
  
  it "should accept a new theme" do
    @graph.theme = Scruffy::Themes::Mephisto
    @graph.theme.should equal(Scruffy::Themes::Mephisto)
  end
  
  it "should accept a new default type" do
    @graph.default_type = :line
    @graph.default_type.should equal(:line)
  end
  
  it "should accept new point markers" do
    markers = ['Jan', 'Feb', 'Mar']
    @graph.point_markers = markers
    @graph.point_markers.should equal(markers)
  end
  
  it "should accept a new renderer" do
    renderer = blank_renderer
    @graph.renderer = renderer
    @graph.renderer.should equal(renderer)
  end
  
  it "should not accept renderers with missing #render methods" do
      lambda { @graph.renderer = 1 }.should raise_error(ArgumentError)
  end
end

describe "A Scruffy::Graph's initialization block" do
  include CustomRenderers
  
  it "should accept just a default_type Symbol" do
    lambda { Scruffy::Graph.new(:line) }.should_not raise_error
  end
  
  it "should accept just an options hash" do
    lambda { Scruffy::Graph.new({:title => "My Title"}) }.should_not raise_error
    lambda { Scruffy::Graph.new(:title => "My Title", :theme => Scruffy::Themes::Keynote) }.should_not raise_error
  end
  
  it "should accept both a default_type and options hash" do
    lambda {
      Scruffy::Graph.new(:line, {:title => "My Title"})
      Scruffy::Graph.new(:line, :title => "My Title")
    }.should_not raise_error
  end
  
  it "should reject any invalid argument combination" do
    lambda { Scruffy::Graph.new({:title => "My Title"}, :line) }.should raise_error(ArgumentError)
    lambda { Scruffy::Graph.new(:line, {:title => "My Title"}, "Any additional arguments.") }.should raise_error(ArgumentError)
    lambda { Scruffy::Graph.new(:line, "Any additional arguments.") }.should raise_error(ArgumentError)
  end
  
  it "should reject any options that are not supported" do
    lambda { Scruffy::Graph.new(:title => "My Title", :some_key => "Some Value") }.should raise_error(ArgumentError)
  end
  
  it "should successfully save all valid options" do
      options = {:title => "My Title",
                 :theme => {:background => [:black], 
                            :colors => [:red => 'red', :yellow => 'yellow']},
                 :layers => [ Scruffy::Layers::Line.new(:points => [100, 200, 300]) ],
                 :default_type => :average,
                 :value_formatter => Scruffy::Formatters::Currency.new,
                 :point_markers => ['One Hundred', 'Two Hundred', 'Three Hundred']}
                 
      @graph = Scruffy::Graph.new(options)

      @graph.title.should == options[:title]
      @graph.theme.should == options[:theme]
      @graph.layers.should == options[:layers]
      @graph.default_type.should == options[:default_type]
      @graph.value_formatter.should == options[:value_formatter]
      @graph.point_markers.should == options[:point_markers]
  end
end


context "A fully populated Graph" do
  setup do
    FileUtils.rm_f File.dirname(__FILE__) + '/*.png'
    FileUtils.rm_f File.dirname(__FILE__) + '/*.jpg'

    @graph = Scruffy::Graph.new :title => 'Test Graph'
    @graph << Scruffy::Layers::Average.new(:title => 'Average', :points => @graph.layers)    
    @graph.layers.first.relevant_data = false
    @graph << Scruffy::Layers::AllSmiles.new(:title => 'Smiles', :points => [100, 200, 300])
    @graph << Scruffy::Layers::Area.new(:title => 'Area', :points => [100, 200, 300])
    @graph << Scruffy::Layers::Bar.new(:title => 'Bar', :points => [100, 200, 300])
    @graph << Scruffy::Layers::Line.new(:title => 'Line', :points => [100, 200, 300])
  end
  
  it "should render to SVG" do
    @graph.render(:width => 800).should be_instance_of(String)
  end
  
  it "should rasterize to PNG" do
    lambda {
      #@graph.render(:width => 800, :as => 'PNG', :to => outfile('test_graph.png'))
    }.should_not raise_error
  end

  it "should rasterize to JPG" do
    lambda {
      #@graph.render(:width => 800, :as => 'JPG', :to => outfile('test_graph.jpg'))
    }.should_not raise_error
  end
end


context "A graph with hash data" do
  specify "should render identically to a graph with array data" do
    @hashgraph = Scruffy::Graph.new :title => 'Graph'
    @hashgraph.add(:line, 'Data', { 0 => 1, 1 => 2, 3 => 4 })
    
    @arraygraph = Scruffy::Graph.new :title => 'Graph'
    @arraygraph.add(:line, 'Data', [1, 2, nil, 4])
    
    @hashgraph.render(:to => outfile('hash.svg')).should == @arraygraph.render(:to => outfile('array.svg'))
  end
end
