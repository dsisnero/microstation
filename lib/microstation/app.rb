require_relative 'wrap'
require_relative 'point3d'
require 'pry'

class WIN32OLE

  def ole_obj
    self
  end

end
module Windows

  class FileSystem

    def self.windows_path(path)
      obj = new
      obj.windows_path(path)
    end

    def fs_object
      @fs_object ||= WIN32OLE.new('Scripting.FileSystemObject')
    end

    def windows_path(path)
      path = path.to_path if path.respond_to? :to_path
      fs_object.GetAbsolutePathName(path.to_str)
    end

  end
end

module Microstation


  module MSD
  end

  def self.win_fs
    @windows_fs ||= Windows::FileSystem.new
  end

  class App

    include Wrap

    def self.run(options={})
      begin
        the_app = new(options)
        binding.pry if the_app.nil?
        yield the_app
      ensure
        the_app.quit unless the_app.nil?
        the_app = nil
      end
    end

    def self.open_drawing(drawing,options={},&block)
      self.run(options) do |app|
        app.open_drawing(drawing,options,&block)
      end
    end

    def run_templates_in_dir(dir,options={})
      yaml_files  = Pathname.glob( Pathname(dir).expand_path + '*.yaml')
      yaml_files.each do |f|
        TemplateRunner.new(f).run_with_app(self,options)
      end

    end

    def render_template(drawing,output_dir: nil ,locals: {} )
      temp = Template.new(drawing,self)
      temp.render(output_dir: output_dir ,locals: locals)
    end

    def self.default_error_proc
      ->(f){ puts "Couldn't open drawing #{f}" }
    end

    def self.default_drawing_options
      {read_only: true, error_proc: default_error_proc}
    end

    def self.default_app_options
      { visible: true }
    end

    def self.with_drawings(*files, &block)
      drawing_options = default_drawing_options
      app_options = default_app_options
      errors = []
      files = files[0] if files[0].kind_of?  Array
      begin
        the_app = new(app_options)
        files_enum = files.each
        loop do
          file = files_enum.next
          puts "opening #{file}.."
          begin
            the_app.open_drawing(file,drawing_options) do |draw|
              block.call draw
            end
            the_app.ole_obj.ole_methods # check if server still open
          rescue => e
            error_proc.call(file)
            the_app = new(app_options)
          end
        end
      ensure
        the_app.quit unless the_app.nil?
        the_app = nil
      end
    end




    def load_constants
      WIN32OLE.const_load(ole_obj, MSD) unless MSD.constants.size > 0
    end

    attr_reader :scanners,:visible

    def initialize(options = {})
      @visible = options.fetch(:visible){ false }
      @ole_obj = init_ole(@visible)
      @windows = Windows::FileSystem.new
      #  make_visible(visible)
      @scanners = {}
    end

    def init_ole(visible=false,tries: 3, sleep_duration: 0.5)
      begin
        ole_obj = WIN32OLE.new('MicrostationDGN.Application')
        sleep(sleep_duration)
        ole_obj.Visible = visible
        ole_obj
      rescue => e
        tries -= 1
        sleep_duration += 1.5
        puts "Error: #{e}. #{tries} tries left."
        retry if tries > 0
        raise
      end
    end

    def visible?
      @visible
    end

    def visible=(bool)
      ole_obj.Visible = bool
    end

    def project_dir
      @project_dir
    end

    def project_dir=(dir)
      @project_dir = dir ? Pathname.new(dir) : dir
    end

    def base_dir
      project_dir ? project_dir : Pathname.getwd
    end

    def normalize_name(name)
      name = Pathname.new(name) unless name.kind_of? Pathname
      name = name.ext('.dgn')  unless name.extname.to_s == /\.(dgn|dwg)$/
      return (base_dir + name).expand_path
    end

    def make_visible(visible)
      @visible = visible
      begin
        ole_obj.Visible = @visible
        true
      rescue Exception => ex
        false
      end
    end

    def ole_obj
      begin
        @ole_obj.ole_methods
        @ole_obj
      rescue => e
        @ole_obj = init_ole(visible)
      end
    end

    # def method_missing(name,*args,&block)
    #   @ole_obj.send(name,*args,&block)
    # end

    def with_drawing(drawing)
      begin
        yield drawing
      ensure
        drawing.close
      end
    end

    def with_template(template)
      template = Template.new(template,self)
      yield template
      template = nil
    end

    def open_drawing(filename,options = {})
      filename = Pathname(filename)
      raise FileNotFound unless filename.file?
      readonly = options.fetch(:read_only){ false}
      error_proc = options[:error_proc]
      begin
        ole = ole_open_drawing(windows_path(filename), readonly)
      rescue => e
        if error_proc
          error_proc.call(filename)
          return
        else
          raise "File #{filename} can't be opened"
        end
      end
      drawing = drawing_from_ole(ole)
      return drawing unless block_given?
      begin
        yield drawing
      rescue
        puts "got error"
      ensure
        drawing.close
      end
    end

    def ole_open_drawing(path, readonly_bool=false, tries: 3, sleep_duration: 1.0)
      begin
        ole = ole_obj.OpenDesignFile(windows_path(path), "ReadOnly" => readonly_bool)
        sleep(sleep_duration)
        ole.ole_methods
        ole
      rescue => e
        tries -= 1
        sleep_duration += 1
        puts "Error: #{e}. #{tries} tries left."
        retry if tries > 0
        raise e
      end
    end

    def windows_path(path)
      @windows.windows_path(path)
    end

    def active_workspace
      ole_obj.ActiveWorkspace
    end

    def configuration
      @config ||= Microstation::Configuration.new(self)
    end

    def username
      configuration["USERNAME"]
    end

    # seedfile A String expression. The name of the seed file. Should not include a path. The default extension is ".dgn".
    # Typical values are "seed2d" or "seed3d".
    # open
    # If the open argument is True, CreateDesignFile returns the newly-opened DesignFile object; this is the same value as
    #  ActiveDesignFile. If the Open argument is False, CreateDesignFile returns Nothing.
    def new_drawing(filename, seedfile=nil     ,open = true,&block)
      #drawing_name = normalize_name(filename)
      seedfile = determine_seed(seedfile)
      binding.pry unless seedfile
      windows_name = windows_path(filename)
      ole = new_ole_drawing(seedfile, windows_name, open)
      drawing = drawing_from_ole(ole)
      return drawing unless block_given?
      begin
        yield drawing
      rescue
      ensure
        drawing.close
      end

    end

     def new_ole_drawing(seedfile, windows_name, open, tries: 3, sleep_duration: 1.0)
       begin
         ole = ole_obj.CreateDesignFile(seedfile, windows_name, open)
         sleep(sleep_duration)
         ole.ole_methods
         ole
       rescue => e
         tries -= 1
         sleep_duration += 1
         puts "Error: #{e}. #{tries} tries left."
         retry if tries > 0
         raise
       end
     end

    def prepend_seed_path(dir)
      configuration.prepend('MS_SEEDFILES', dir)
    end

    def drawing_from_ole(ole)
      Drawing.new(self,ole)
    end

    def determine_seed(seedfile)
      return configuration['MS_DESIGNSEED'] unless seedfile
      seed = find_seed(seedfile)
      return seed.to_s if seed
      raise "Seedfile #{seedfile} not found in #{configured_seed_paths}"
    end

    def configured_seed_paths
      configuration['MS_SEEDFILES']
    end


    def find_seed(seedfile)
      seed = Pathname(seedfile).expand_path.sub_ext(".dgn")
      return seed if seed.file?
      find_seed_in_seed_dirs(seed.basename)
    end

    def find_seed_in_seed_dirs(seedfile)
      seed_dir = seed_paths.find{|p| (p + seedfile).file?}
      return (seed_dir + seedfile) if seed_dir
    end

    def seed_paths
      configured_seed_paths.split(';').map{|d| Pathname(d)}
    end

    def eval_cexpression(string)
      ole_obj.GetCExpressionValue(string)
    end

    def quit
      active_design_file.close if active_file?
      @scanners.each{|name,sc| sc.close}
      ole_obj.Quit rescue nil
    end

    def active_design_file
      ole = ole_obj.ActiveDesignFile rescue nil
      drawing_from_ole(ole) if ole
    end

    def current_drawing
      active_design_file
    end

    #   alias :current_drawing :active_design_file

    def close_active_drawing
      active_design_file.close if active_design_file
    end

    def active_file?
      !!active_design_file
    end

    def file_exists?(file)
      File.file?( File.expand_path(file) )
    end

    def create_scanner(name=nil,&block)
      Microstation::Scan::Criteria.create_scanner(name,self,&block)
    end

    def text_criteria
      sc = scanners[:textual] || create_scanner(:textual){ include_textual}
      sc
    end

    def tags_criteria
      sc = scanners[:tags] || create_scanner(:tags){ include_tags}
    end

    def create_scan_criteria(name = nil, &block)
      Microstation::Scan::Criteria.create_scanner(name,self,&block)
    end

    # def find_by_id(id)
    #   active_design_file.find_by_id(id)
    #   wrap(model) if el
    # end

    def scan(criteria =  nil,model = nil)
      model  = model || active_model_reference
      model.scan(criteria)
    end

    def get_ole_element_enumerator(model:, criteria: nil)
      begin
        criteria = create_scan_criteria unless criteria
        criteria.resolve
        model.scan(criteria.ole_obj)
      rescue Exception
        # binding.pry
      end
    end


    def cad_input_queue

      queue = init_cad_input_queue
      return queue unless block_given?
      begin
        yield queue
      rescue

      ensure
        queue.close
        queue = nil
      end
    end

    def can_open?(filename)
      ext = File.extname(filename)
      (ext == ".dwg") || (ext == ".dgn")
    end

    def active_model_reference
      DefaultModel.new(self,ole_obj.ActiveModelReference) rescue nil
    end

    def default_model
      DefaultModel.new(self,ole_obj.DefaultModelReference) rescue nil
    end


    def Point3d(x,y,z=0)
      ole = ::WIN32OLE_RECORD.new('Point3d', ole_obj)
      ole.X = x
      ole.Y = y
      ole.Z = z
      point = Point3d.new(ole,self)
    end


    def create_ole_type(name)
      ole_type = get_ole_type(name)
      return nil unless ole_type
      #WIN32OLE.new(ole_type.guid)
    end


    def get_ole_type(name)
      typelib.ole_classes.find{|t| t.name == name}
    end

    private

    def init_cad_input_queue
      Microstation::CadInputQueue.new(ole_obj.CadInputQueue)
    end


    def typelib
      ole_obj.ole_typelib
    end

  end

end
