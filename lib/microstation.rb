require 'win32ole'
require 'microstation/app'
require 'microstation/drawing'
require 'microstation/configuration'
require 'microstation/ext/pathname'
require 'microstation/cad_input_queue'

module Microstation
  VERSION = '1.0.0'

  def self.root
    Pathname.new( File.dirname(__FILE__)).parent
  end

  def self.plot_driver_directory
    root + plot
  end
  
end
