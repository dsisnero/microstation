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

  def self.with_drawings(*files, &block)
    files = files[0] if files[0].kind_of?  Array
    opts = {:read_only => true}
    app = Microstation::App.run do |app|
      files.each do |file|
        puts "opening #{file}.."
        app.open_drawing(file,opts) do |draw|
          block.call draw
        end

      end
    end
  end

  def self.run(options, &block)
    options = {:visible => false}.merge(options)
    begin
      app = Microstation::App.new(options)
      block.arity < 1 ? app.instance_eval(&block) : block.call(app)
    ensure
      app.quit
    end
  end

end
