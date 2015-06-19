require 'microstation/version'
require 'win32ole'
require 'microstation/file_tests'
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
require 'microstation/ext/win32ole'
require 'microstation/template_info'
require 'microstation/template_runner'
require 'erb'

module Microstation


  def self.root
    Pathname.new( File.dirname(__FILE__)).parent
  end


  def self.app
    @app ||= Microstation::App.new
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

  def self.dump_template_info(dir)
    drawings = drawings_in_dir(dir)
    self.with_drawings(drawings) do |drawing|
      template = TemplateInfo.new(drawing)
      template.dump(dir)
    end
  end

  def self.dgn2pdf(dir,output = dir)
    drawings = drawings_in_dir(dir)
    self.with_drawings(drawings) do |drawing|
      drawing.save_as_pdf(drawing.name,output)
    end
  end

  def self.run_templates_in_dir(dir)
    self.run do |app|
      app.run_templates_in_dir(dir)
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

  def self.scan_text(file,&block)
    Microstation.open_drawing(file) do |d|
      d.scan_text(&block)
    end
  end

  def self.get_text(file)
    result = []
    Microstation.open_drawing(file) do |d|
      result = d.get_text
    end
    result
  end

  def self.get_all_text(file)
    Microstation.open_drawing(file) do |d|
      d.get_all_text
    end
  end

  def self.run(options={}, &block)
    options = {:visible => false}.merge(options)
    begin
      app = Microstation::App.new(options)
      block.arity < 1 ? app.instance_eval(&block) : block.call(app)
    ensure
      app.quit rescue nil
      app = nil
    end
  end

end


if $0 == __FILE__

  require 'pry'

  app = Microstation::App.new
  tlib = app.ole_obj.ole_typelib
  File.open('microstation_classes.txt','w') do |f|
    tlib.ole_classes.each do |k|
      if k.ole_type == "Class"
        f.puts k.name
        f.puts k.progid
        f.puts k.guid
        f.puts "---"
      end
    end
  end
  drawing = app.new_drawing('mynew.dgn')

  le =tlib.ole_classes.find{|c| c.name == 'LineElement'}
  #puts drawing.model_names

  VT = WIN32OLE::VARIANT
  # Type.Missing equivalent

  e1 = WIN32OLE_VARIANT::NoParam
  e2 = WIN32OLE_VARIANT.new(nil, VT::VT_VARIANT|VT::VT_BYREF)


  drawing.change_model('Default')
  line = drawing.create_line [1,0.5],[1,1,0],e1
  drawing.add_line line if line



  binding.pry


  app.quit



end
