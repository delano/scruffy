$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

def outfile( name )
  output_dir = File.join(File.dirname(__FILE__), "output")
  
  FileUtils.mkdir( output_dir ) unless File.exist?( output_dir )
  File.join( output_dir, name )
end