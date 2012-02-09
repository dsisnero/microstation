require_relative 'wrap'
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
      fs_object.GetAbsolutePathName(path)
    end

  end
end



module Microstation

  module MSD
  end
  


  class App

    include Wrap

    def self.run(options={})
      begin
        the_app = new(options)
        
        yield the_app
      ensure
        self.quit
      end
    end

    def load_constants      
      WIN32OLE.const_load(@ole_obj, MSD) unless MSD.constants.size > 0
    end

    attr_reader :scanners
    
    def initialize(options = {})
      visible = options.fetch(:visible){ true }
      
      @ole_obj = WIN32OLE.new('MicrostationDGN.Application')
      @windows = Windows::FileSystem.new
      make_visible(visible)
      @scanners = []
    end

    def visible?
      @visible
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
      name = Pathname.new(name)
      name = name.ext('.dgn')  unless name.extname.to_s == /\.(dgn|dwg)$/
      return (base_dir + name).expand_path
    end     

    def make_visible(visible)
      @visible = visible
      @ole_obj.Visible = @visible
    end

    attr_reader :ole_obj

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


    def open_drawing(filename,options = {})
      raise FileNotFound unless file_exists?(filename)
      readonly = options.fetch(:read_only){ false}
      ole = @ole_obj.OpenDesignFile(windows_path(filename), "ReadOnly" => readonly)
      drawing = Drawing.new(self, ole)
      return drawing unless block_given?
      begin
        yield drawing
      rescue
        puts "got error"
      ensure
        drawing.close
      end
      
    end

    def windows_path(path)
      @windows.windows_path(path.to_s)
    end

    def active_workspace
      @ole_obj.ActiveWorkspace
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
    def new_drawing(filename, seedfile="seed2d",open = true,&block)
      drawing_name = normalize_name(filename)
      ole = @ole_obj.CreateDesignFile(seedfile, windows_path(drawing_name), open)
      drawing = Drawing.new(self, ole)
      return drawing unless block_given?
      begin
        yield drawing
      rescue
      ensure
        drawing.close
      end
      
    end

    def eval_cexpression(string)
      @ole_obj.GetCExpressionValue(string)
    end

    def quit
      active_design_file.close if active_file?
      @scanners.each{|sc| sc.close}
      @ole_obj.quit
    end

    def active_design_file
      @ole_obj.ActiveDesignFile rescue nil
    end

    def close_active_drawing
      active_design_file.close if active_design_file
    end

    def active_file?
      !!active_design_file
    end

    def file_exists?(file)
      File.file?( File.expand_path(file) )
    end

    def create_scanner
      criteria = Microstation::Scan::Criteria.create(self)
      return criteria unless block_given?
      yield criteria
      criteria
    end

    def find_by_id(id)
      model = active_model_reference.GetElementById(id)
      wrap(model)
    end    

    def scan(criteria = nil)
      result = []
      raise 'NoActiveModel' unless active_model_reference
      if criteria
        criteria.resolve
        ee = active_model_reference.Scan(criteria.ole_obj)
      else
        ee = active_model_reference.Scan(nil)
      end
      scan_result = Microstation::Enumerator.new ee
      return scan_result.to_enum unless block_given?
      scan_result.each do |item|
        yield item
      end
      nil
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
      @ole_obj.ActiveModelReference rescue nil
    end 

     private

 
    

    def init_cad_input_queue
      Microstation::CadInputQueue.new(@ole_obj.CadInputQueue)
    end


  end

end

