require "microstation/version"
require "win32ole"
require "microstation/file_tests"
require "microstation/app"
require "microstation/drawing"
require "microstation/configuration"
require "microstation/ext/pathname"
require "microstation/cad_input_queue"
require "microstation/scan/criteria"
require "microstation/enumerator"
require "microstation/line"
require "microstation/text"
require "microstation/text_node"
require "microstation/template"
require "microstation/tag_set"
require "microstation/cell"
require "microstation/tag"
require "microstation/dir"
require "microstation/ext/win32ole"
require "microstation/template_info"
require "microstation/template_runner"
require "erb"

module Microstation
  ROOT = Pathname(__dir__).parent

  TEMPLATES_PATH = ROOT + "templates"

  class << self
    def save_as_pdf(d)
      run do |app|
        drawing = app.current_drawing
        drawing.save_as_pdf(dir: d)
        drawing.close
      end
    end

    def default_error_proc
      @default_error_proc ||= ->(e, f) { puts "Couldn't open drawing #{f}" }
    end

    def default_drawing_options
      {read_only: true, error_proc: default_error_proc}
    end

    attr_writer :default_error_proc

    attr_reader :default_app_options

    attr_writer :default_app_options

    default_app_options = {visible: false}

    def root
      ROOT
    end

    def plot_driver_directory
      root + "plot"
    end

    def use_template(template, context, options = {})
      def context.binding
        binding
      end
      options = {readonly: true}
      App.run do |app|
        tmpfile = Tempfile.new("drawing")
        app.new_drawing(tmpfile, template) do |drawing|
          drawing.scan_text do |text|
            compiled_template = ERB.new(text)
            new_text = compiled_template.result(context.binding)
            text = new_text
          end
        end
      end
      tempfile.read
    end

    # starts an app with drawing, opens a temp
    # copy of the drawing and yields it
    # saves the drawing with with name or output_dir
    # same name
    #
    # @param dgn
    # @yield [Drawing]
    def change_drawing(...)
      App.change_drawing(...)
    end

    # gets all dwg and dgn dfiles in a directory
    # @param dir
    def drawings_in_dir(dir)
      dirpath = Pathname.new(dir).expand_path
      drawings = dirpath.glob("*.d{gn,wg,xf}").sort_by { _1.basename(".*").to_s.downcase }
    end

    def dump_template_info_for_dir(dir, **options)
      drawings = drawings_in_dir(dir)
      raise "no drawings in dir #{dir}" if drawings.empty?
      with_drawings(drawings) do |drawing|
        template = TemplateInfo.new(drawing, **options)
        template.dump(dir)
      end
    end

    def dump_template_info(dgn, dir: nil, tagset_filter: nil, visible: false)
      drawing = Pathname(dgn).expand_path
      output_dir = dir || drawing.parent
      template = TemplateInfo.new(drawing, tagset_filter: tagset_filter, visible: visible)
      template.dump(output_dir)
    end

    # @param dir [String] the directory of drawing [dgn,dwg] to convert
    # @param outdir [String] the output dir for converted pdf files
    def dgn2pdf(dir, outdir = dir)
      drawings = drawings_in_dir(dir)
      with_drawings(drawings) do |drawing|
        drawing.save_as_pdf(name: drawing.name, dir: outdir)
      end
    end

    def run_templates_in_dir(...)
      App.run_templates_in_dir(...)
    end

    # starts app, opens drawing, and yields
    # the drawing before closing drawing and
    # quitting the app
    def open_drawing(...)
      App.open_drawing(...)
    end

    # opens all the drawings in a drawing
    # by calling open drawing
    def with_drawings_in_dir(dir, ...)
      drawings = drawings_in_dir(dir)
      with_drawings(drawings, ...)
    end

    def with_drawings(...)
      App.with_drawings(...)
    end

    def scan_text(file, &block)
      App.open_drawing(file) do |d|
        d.scan_text(&block)
      end
    end

    def get_text(file, &block)
      App.open_drawing(file) do |d|
        d.get_text(&block)
      end
    end

    def get_all_text(file)
      App.open_drawing(file) do |d|
        d.get_all_text
      end
    end

    def save_current_drawing(dir, exit: true)
      if exit
        run do |app|
          drawing = app.current_drawing
          drawing.copy(dir: dir)
          drawing.save_as_pdf(dir: dir)
          drawing.close
        end
      else
        app = App.new
        drawing = app.current_drawing
        drawing.copy(dir: dir)
        drawing.save_as_pdf(dir: dir)
        app
      end
    end

    def save_current_drawing_as_pdf(dir)
      App.run do |app|
        drawing = app.current_drawing
        drawing.save_as_pdf(dir: dir)
        drawing.close
      end
    end

    def run(options = {}, &block)
      App.run(options, &block)
    end
  end
end

if $0 == __FILE__

  require "pry"

  app = Microstation::App.new
  require "microstation/ole_helper"

  File.write("app_methods.txt", app.ole_obj.ole_methods_detail)

  tlib = app.ole_obj.ole_typelib
  File.write("microstation_classes.txt", app.ole_obj.ole_classes_detail)

  ole_obj = app.ole_obj

  event_classes = ole_obj.select_ole_type("event")
  puts event_classes


  # drawing = app.new_drawing('mynew.dgn')

  # le =tlib.ole_classes.find{|c| c.name == 'LineElement'}
  # #puts drawing.model_names

  # VT = WIN32OLE::VARIANT
  # # Type.Missing equivalent

  # e1 = WIN32OLE_VARIANT::NoParam
  # e2 = WIN32OLE_VARIANT.new(nil, VT::VT_VARIANT|VT::VT_BYREF)


  # drawing.change_model('Default')
  # line = drawing.create_line [1,0.5],[1,1,0],e1
  # drawing.add_line line if line



  binding.pry


  app.quit



end
