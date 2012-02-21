require 'win32ole'
require 'microstation/app'
require 'microstation/drawing'
require 'microstation/configuration'
require 'microstation/ext/pathname'
require 'microstation/cad_input_queue'
require 'microstation/scan/criteria'
require 'microstation/enumerator'
require 'microstation/text'
require 'microstation/text_node'

module Microstation
  VERSION = '0.3.0'

  def self.root
    Pathname.new( File.dirname(__FILE__)).parent
  end

  def self.plot_driver_directory
    root + "plot"
  end
  

  def self.run(&block)
    begin
      app = Microstation::App.new
      block.arity < 1 ? app.instance_eval(&block) : block.call(app)
    ensure
      app.quit
    end
    
    
  end

end

