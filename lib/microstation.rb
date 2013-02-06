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
require 'microstation/template'
require 'microstation/tag_set'
require 'microstation/tag'
require 'microstation/dir'

require 'erb'

module Microstation
  VERSION = '0.4'

  def self.root
    Pathname.new( File.dirname(__FILE__)).parent
  end


  def self.app
    Microstation::App.new
  end


  def self.plot_driver_directory
    root + "plot"
  end

  def self.use_template(template,context)
    def context.binding
      binding
    end
    opts = {:read_only => true}
    Microstation::App.run do |app|
      tmpfile = Tempfile.new('drawing')
      app.new_drawing(tmpfile,template) do |drawing|
        drawing.scan_text do |text|
          compiled_template = ERB.new(text)
          new_text = compiled_template.result(context.binding)
          text = new_text
        end
      end
    end
    tempfile.read
  end

  def self.drawings_in_dir(dir)
    dirpath = Pathname.new(dir).expand_path
    drawings = Pathname.glob("#{dirpath}/*.d{gn,wg}")
  end

  def self.dgn2pdf(dir,output = dir)
    drawings = drawings_in_dir(dir)
    self.with_drawings(drawings) do |drawing|
      drawing.save_as_pdf(drawing.name,output)
    end
  end

  def self.open_drawing(drawing,options = {}, &block)
    Microstation::App.open_drawing(drawing,options,&block)
  end

  def self.with_drawings_in_dir(dir,&block)
    drawings = self.drawings_in_dir(dir)
    self.with_drawings(drawings,&block)
  end

  def self.with_drawings(*files, &block)
    Microstation::App.with_drawings(*files,&block)
  end

  def self.run(options={}, &block)
    options = {:visible => false}.merge(options)
    begin
      app = Microstation::App.new(options)
      block.arity < 1 ? app.instance_eval(&block) : block.call(app)
    ensure
      app.quit
    end
  end

end
