# frozen_string_literal: true

require_relative "wrap"
require_relative "point3d"
require_relative "event_handler"
require_relative "functions"
require "debug"

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

    # Convert path to windows path
    # @param path [String, Pathname] the path you want to convert
    def windows_path(path)
      path = path.to_path if path.respond_to? :to_path
      fs_object.GetAbsolutePathName(path.to_str)
    end

    def fs_object
      @fs_object ||= WIN32OLE.new("Scripting.FileSystemObject")
    end
  end
end

module Microstation
  class App
    include Functions

    @default_error_proc = ->(e, f) {
      puts "Couldn't open drawing #{f}"
      puts e.backtrace
    }

    class << self
      attr_accessor :default_error_proc

      def default_app_options
        {visible: false, error_proc: @default_error_proc, wait_time: 500, wait_interval: 0.5}
      end



      #  include Wrap

      # Initialize an instance of app with the options
      # @param [Hash] options the options to create the app with
      # @option options [Boolean] :visible Is the app visible
      #
      # [source]
      # ----
      # App.run do |app|
      #   drawing = app.open_drawing('test.dgn')
      #   drawing.scan_all_text do |model,text|
      #   puts "#{model} #{text}"
      #   end
      # end
      #
      # @yield [App] the_app yields the instanciated app
      # @return [void]
      def run(options = {})
        opts = default_app_options.merge(options)
        err_fn = opts.fetch(:error_proc, default_error_proc)
        begin
          the_app = new(**opts)
          binding.break if the_app.nil?
          yield the_app
        rescue => e
          if e.respond_to? :drawing
            err_fn.call(e, e.drawing)
          else
            err_fn.call(e, nil)
          end
        ensure
          the_app.quit if the_app.respond_to? :quit
          the_app = nil
          GC.start
          nil
        end
      end

      # Calls #run to get an app instance then call open drawing with
      # that app
      # (see #open_drawing)
      # @yield Drawing
      # @return [void]
      def open_drawing(drawing, **options, &block)
        run(**options) do |app|
          app.open_drawing(drawing, **options, &block)
        end
      end

      # Runs the app, opening the filenames
      # and yielding each open drawing to the
      # supplied block
      # it automatically closes the drawing and
      # the app when done
      #
      # [source]
      # dir = Pathname('C:/templates')
      # drawings = Pathname.glob(dir + '/**/*.dgn')
      # App.with_drawings(drawings) do |drawing|
      #   drawing.save_as_pdf(dir: 'c:/output/')
      # end
      #
      # @param files [Array<String,Pathname>]
      # @param visible [Boolean]
      # @param readonly [Boolean]
      # @param error_proc [Proc]
      # @yield [Drawing]
      # @return [void]
      def with_drawings(*files, **options, &block)
        # drawing_options = default_drawing_options.merge(options)
        # app_options = default_app_options
        opts = default_app_options.merge(options)
        files = files[0] if files[0].is_a? Array
        opt_visible = options.delete(:visible) || false
        error_proc = options.delete(:error_proc)
        begin
          the_app = new(**opts)
          files_enum = files.each
          loop do
            file = files_enum.next
            puts "opening #{file}.."
            begin
              the_app.open_drawing(file, **options, &block)
              the_app.ole_obj.ole_methods # check if server still open
            rescue => e
              raise e unless error_proc

              error_proc.call(e, file)
              the_app = new(visible: opt_visible)
            end
          end
        ensure
          the_app&.quit
          the_app = nil
        end
      end
    end

    attr_reader :scanners, :visible, :app_event, :project_dir, :error_proc

    # Constructor for app
    # @param [Boolean] visible
    # @param event_handler [EventHandler]
    def initialize(visible: false, error_proc: self.class.default_error_proc, event_handler: default_event_handler, wait_interval: nil, wait_time: nil)
      @visible = visible
      @event_handler = event_handler
      @ole_obj, @app_event = init_ole_and_app_event(visible: @visible, event_handler: @event_handler, tries: 5,
        sleep_duration: 0.5)
      @run_loop = true
      @windows = Windows::FileSystem.new
      #  make_visible(visible)
      @scanners = {}
      @error_proc = error_proc
    rescue => e
      @error_proc.call(e, nil)
    end

    def run_templates_in_dir(dir, options = {})
      yaml_files = Pathname.glob("#{Pathname(dir).expand_path}*.yaml")
      yaml_files.each do |f|
        TemplateRunner.new(f).run_with_app(self, options)
      end
    end

    def change_drawing(dgn, output_dir: nil, name: nil, options: {}, &block)
      changer = Changer.new(dgn, name: name, output_dir: output_dir, app: self)
      changer.run(&block)
    end

    def render_template(drawing, output_dir: nil, locals: {}, name: nil)
      temp = Template.new(drawing, output_dir: output_dir, app: self, name: name)
      temp.render(output_dir: output_dir, locals: locals)
    end

    #
    # the default EventHandler
    #
    # @return [EventHandler] returns the default EventHandler
    #
    def default_event_handler
      event_handler = EventHandler.new
      event_handler.add_handler("OnDesignFileOpened") do |*_args|
        puts "drawing opened"
        @drawing_opened = true
      end
      event_handler.add_handler("OnDesignFileClosed") do |*_args|
        @drawing_opened = false
        puts "drawing closed"
      end
      event_handler
    end

    #
    # register an handler
    #
    # @param [String] event key for handler
    # @param [<Type>] &block <description>
    #
    # @return [<Type>] <description>
    #
    def register_handler(event, &block)
      @event_handler.add_handler(event, &block) unless event == "OnQuit"
    end

    #
    # return a Handler
    #
    # @param [String,Symbol] event the event key
    #
    # @return [Proc] returns the Proc given by event name
    #
    def get_handler(event)
      @event_handler.get_handler(event)
    end

    def exit_message_looop
      puts "Microstation exiting..."
      @run_loop = false
    end

    def wait_drawing_opened(secs, interval = 1)
      elapsed = 0
      while !drawing_opened? && elapsed <= secs
        elapsed += interval
        sleep(interval)
        WIN32OLE_EVENT.message_loop
      end
    end

    def init_ole_and_app_event(visible: @visible, event_handler: @event_handler, tries: 5, sleep_duration: 1)
      ole = WIN32OLE.new("MicrostationDGN.Application")
      sleep(sleep_duration)
      ole.Visible = visible
      ole.IsProcessLocked = true
      load_constants(ole)
      app_event = WIN32OLE_EVENT.new(ole)
      app_event.handler = event_handler
      [ole, app_event]
    rescue => e
      tries -= 1
      sleep_duration += 1.5
      puts "Error: #{e}. #{tries} tries left."
      retry if tries.positive?
      raise e, "unable to init ole app"
    end

    # @return [Boolean] whether the app is visible
    def visible?
      @visible
    end

    #
    # Change the visible attribute
    #
    # @param [Boolean] bool true or false to make it visible
    #
    # @return [void]
    #
    def visible=(bool)
      make_visible !!bool
    end

    def default_app_options
      self.class.default_app_options
    end

    def project_dir=(dir)
      @project_dir = dir ? Pathname.new(dir) : dir
    end

    def base_dir
      project_dir || Pathname.getwd
    end

    def wrap(item, cell = nil)
      Element.convert_item(item, self, cell)
    end

    def normalize_name(name)
      name = Pathname.new(name) unless name.is_a? Pathname
      name = name.ext(".dgn") unless name.extname.to_s == /\.(dgn|dwg)$/
      (base_dir + name).expand_path
    end

    def make_visible(visible)
      @visible = visible
      begin
        ole_obj.Visible = @visible
        true
      rescue
        false
      end
    end

    def ole_obj
      is_ok = true
      begin
        @ole_obj.Visible
      rescue
        is_ok = false
      end

      @ole_obj, @app_event = init_ole_and_app_event(tries: 3) unless is_ok

      @ole_obj
    end

    def with_drawing(drawing)
      yield drawing
    ensure
      drawing.close
    end

    def with_template(template)
      template = Template.new(template, self)
      yield template
      template = nil
    end

    # open the drawing
    # @param filename [String] the name of the file to open
    # @param  [Boolean] :readonly  (false)
    # @param  [Proc] :error_proc (raise) a proc to run
    # @param wait_time [Integer] the total amount of time to wait to open file (500)
    # @param wait_interval [Float] the amount of time in seconds to wait before retry (0.5)
    # @yield [Drawing] drawing
    # @return [void]
    def open_drawing(filename, options: {})
      opts = default_app_options.merge(options)
      err_fn = opts.fetch(:error_proc, error_proc)
      filename = Pathname(filename)
      raise FileNotFound unless filename.file?

      begin
        ole = ole_open_drawing(windows_path(filename), readonly: opts[:readonly], wait_time: opts[:wait_time], wait_interval: opts[:wait_interval])
      rescue DrawingError => e
        raise e unless err_fn

        err_fn.call(e, e.drawing)
      end
      drawing = drawing_from_ole(ole)
      return drawing unless block_given?

      begin
        yield drawing
      rescue => e
        raise e unless err_fn
        err_fn.call(e, filename)
      ensure
        drawing.close
      end
    end

    def drawing_opened?
      @drawing_opened
    end

    def windows_path(path)
      @windows.windows_path(path)
    end

    def active_workspace
      ole_obj.ActiveWorkspace
    end

    # @return the [Configuration]
    def configuration
      @config ||= ::Microstation::Configuration.new(self)
    end

    # @return [String] the configuration variable USERNAME
    def username
      configuration["USERNAME"]
    end

    # create a new drawing
    # @param filename [String,Pathname] the name of the file
    # @param seedfile [String] The name of the seed file.
    #  should not include a path. The default extension is ".dgn".
    #  Typical values are "seed2d" or "seed3d".
    # @param open [Boolean] .If the open argument is True,
    #   CreateDesignFile returns the newly-opened DesignFile object;
    #   this is the same value as ActiveDesignFile. If the Open argument is False,
    #   CreateDesignFile returns Nothing.
    # @return [Drawing]
    def new_drawing(filename, seedfile: nil, open: true, options: {}, &block)
      opts = default_app_options.merge(options)
      err_fn = opts.fetch(:error_proc, error_proc)
      file_path = Pathname(filename).expand_path
      raise ExistingFile, file_path if file_path.exist?

      # drawing_name = normalize_name(filename)
      seedfile = determine_seed(seedfile)
      binding.break unless seedfile
      windows_name = windows_path(filename)
      ole = new_ole_drawing(seedfile, windows_name, open: open, wait_time: opts[:wait_time], wait_interval: opts[:wait_interval])
      drawing = drawing_from_ole(ole)
      return drawing unless block

      begin
        yield drawing
      rescue DrawingError => e
        err_fn.call(e, e.drawing)
      rescue => e
        err_fn.call(e, file_path)
      ensure
        drawing.close
      end
    end

    def new_ole_drawing(seedfile, new_design_file_name, open: true, wait_time: 500, wait_interval: 0.5)
      ole = ole_obj.CreateDesignFile(seedfile, new_design_file_name, open)
      wait_drawing_opened(wait_time, wait_interval)
      return ole if drawing_opened?
      raise DrawingError.new("New drawing not opened in #{wait_time}", new_design_file_name)
    end

    def has_current_drawing?
      ole_obj.HasActiveDesignFile
    end

    # prepend a dir to the MS_SEEDFILES configuration
    # @param dir [String,Pathname]
    def prepend_seed_path(dir)
      configuration.prepend("MS_SEEDFILES", windows_path(dir))
    end

    def drawing_from_ole(ole)
      Drawing.new(self, ole)
    end

    def determine_seed(seedfile)
      return configuration["MS_DESIGNSEED"] unless seedfile

      seed = find_seed(seedfile)
      return seed.to_s if seed

      raise "Seedfile #{seedfile} not found in #{configured_seed_paths}"
    end

    # @return [String] the configuration variable MS_SEEDFILES
    def configured_seed_paths
      configuration["MS_SEEDFILES"]
    end

    # find the seedfile
    # @param [String,Pathname] seedfile
    #
    # * If the seed file is absolute and found the return the
    # seedfile.
    # * If the seed file is not found search MS_SEEDFILES
    # @return [Pathname] seedfile the found seedfile
    def find_seed(seedfile)
      seed = Pathname(seedfile).expand_path.sub_ext(".dgn")
      return seed if seed.file?

      find_seed_in_seed_dirs(seed.basename)
    end

    def find_seed_in_seed_dirs(seedfile)
      seed_dir = seed_paths.find { |p| (p + seedfile).file? }
      return (seed_dir + seedfile) if seed_dir
    end

    # @return [Array] returns the MS_SEEDFILES as Pathnames Array
    def seed_paths
      configured_seed_paths.split(";").map { |d| Pathname(d) }
    end

    def eval_cexpression(string)
      ole_obj.GetCExpressionValue(string)
    end

    #
    # quit the app
    #
    # @return [void]
    #
    def quit
      close_active_drawing
      @scanners.each { |_name, sc| sc.close }
      begin
        ole_obj.Quit
      rescue
        nil
      end
    end

    # the active design file
    # @return [Drawing]
    def active_design_file
      return unless active_design_file?

      ole = ole_obj.ActiveDesignFile
      drawing_from_ole(ole)
    end

    alias_method :active_drawing, :active_design_file
    alias_method :current_drawing, :active_design_file

    #
    # close the active_design_file
    #
    # @return [void]
    #
    def close_active_drawing
      active_design_file.close if active_design_file?
    end

    alias_method :close_current_drawing, :close_active_drawing

    #
    #
    #
    # @return [Boolean] true if app has an active design file open
    #
    def active_design_file?
      ole_obj.HasActiveDesignFile
    end

    alias_method :current_design_file?, :active_design_file?

    #
    # <Description>
    #
    # @param [String,Pathname] file name of file to search for
    #
    # @return [Boolean] true if file exists
    #
    def file_exists?(file)
      Pathname(file).expand_path.file?
    end

    def create_scanner(name = nil, &block)
      ::Microstation::Scan::Criteria.create_scanner(name, self, &block)
    end

    def text_criteria
      scanners[:textual] || create_scanner(:textual) { include_textual }
    end

    def tags_criteria
      scanners[:tags] || create_scanner(:tags) { include_tags }
    end

    def create_scan_criteria(name = nil, &block)
      ::Microstation::Scan::Criteria.create_scanner(name, self, &block)
    end

    # def find_by_id(id)
    #   active_design_file.find_by_id(id)
    #   wrap(model) if el
    # end

    def scan_model(criteria = nil, model = nil)
      model ||= active_model_reference
      model.scan(criteria)
    end

    def get_ole_element_enumerator(model:, criteria: nil)
      criteria ||= create_scan_criteria
      criteria.resolve
      model.scan(criteria.ole_obj)
    rescue Exception
      # binding.break
    end

    # lets you interact with the cad_input_queue
    # @yield [CadInputQueue]
    # @return [void]
    def cad_input_queue
      queue = init_cad_input_queue
      return queue unless block_given?

      begin
        yield queue
      rescue
      ensure
        queue.close
        queue = nil
        @cad_input_queue = nil
      end
    end

    def show_command(text)
      ole_obj.ShowCommand(text)
    end

    def show_prompt(text)
      ole_obj.ShowPrompt(text)
    end

    def show_message(text)
      ole_obj.ShowMessage(text)
    end

    #
    #
    # @param [String] text text to show
    # @param [Symbol] location (one of :left, :middle)
    #
    # @return [void]
    #
    def show_temp_message(text, location: nil)
      loc = case location
      when :left
        MSD::MsdStatusBarAreaLeft
      when :middle
        MSD::MsdStatusBarAreaMiddle
      else
        MSD::MsdStatusBarAreaLeft
      end
      ole_obj.ShowTempMessage(loc, text)
    end

    def can_open?(filename)
      ext = File.extname(filename)
      (ext == ".dwg") || (ext == ".dgn")
    end

    def active_model_reference
      DefaultModel.new(self, ole_obj.ActiveModelReference)
    rescue
      nil
    end

    def default_model
      DefaultModel.new(self, ole_obj.DefaultModelReference)
    rescue
      nil
    end

    def ole_point
      ::WIN32OLE_RECORD.new("Point3d", ole_obj)
    end

    def ole_rotation
      ::WIN32OLE_RECORD.new("Rotation", ole_obj)
    end

    def ole_matrix
      ::WIN32OLE_RECORD.new("Matrix", ole_obj)
    end

    #
    # Create an WIN32OLE_RECORD of type Point3d
    #
    # @param [Numeric] x coordinate in x axis
    # @param [Numeric] y coordinate in y axis
    # @param [Numeric] z coordinate in z direction (0.0)
    #
    # @return [WIN32OLE_RECORD] record of type Point3d
    #
    def create_ole_point(x, y, z = 0)
      ole = ole_point
      ole.X = x
      ole.Y = y
      ole.Z = z
      ole
    end

    def to_ole_matrix3d(vec)
      if vec.instance_of?(WIN32OLE_RECORD) && vec.typename == "Matrix3d"
        vec
      else
        binding.break
      end
    end

    #
    # Conversion to WIN32OLE_RECORD of type Point3d
    #
    # @param [WIN32OLE_RECORD, Point3d, Array<Numeric>] pt Point to normalize to ole point
    # @return [WIN32OLE_RECORD] 'Point3d' WIN32OLE_RECORD
    #
    def to_ole_point3d(pt)
      case pt
      when ole_point3d?(pt)
        pt
      when Point3d
        create_ole_point(pt.x, pt.y, pt.z)
      when Array
        pt1 = pt.map(&:to_f)
        x, y, z = pt1
        z ||= 0.0
        create_ole_point(x, y, z)
      end
    end

    #
    # <Description>
    #
    # @param [Object] pt pt object to test if it is a WIN32OLE_RECORD of 'Point3d'
    #
    # @return [Boolean] true if pt is WIN32OLE_RECORD of 'Point3d'
    #
    def ole_point3d?(pt)
      pt.instance_of?(WIN32OLE_RECORD) && pt.typename == "Point3d"
    end

    def create_text_node(origin, rotation, temp = nil)
      ole_origin = to_ole_point3d(origin)
      ole_rotation = to_ole_matrix3d(rotation)
      temp ||= WIN32OLE_VARIANT::Nothing
      ole_obj.CreateTextNodeElement1(temp, ole_origin, ole_rotation)
    rescue Exception => e
      puts e.message
      nil
    end

    #
    # convert pt to Point3d
    #
    # @param [Array<Numeric,Numeric,Numeric>, Point3d, WIN32OLE_RECORD] pt Point to convert
    #
    # @return [Point3d]
    #
    def to_point3d(pt)
      case pt
      when Array
        pt_a = pt.map(&:to_f)
        x, y, z = pt_a
        z ||= 0.0
        Point3d.new(x, y, z)
      when Point3d
        pt
      when WIN32OLE_RECORD
        Point3d.from_ole(pt) if pt.typename == "Point3d"
      end
    end

    def to_point(pt)
      to_point3d(pt)
    end

    def start_primitive(klass)
      ole_obj.CommandState.StartPrimitive klass.new(self)
    end

    def my_place_line
      require_relative "primitive_command_interface"
      start_primitive LineCreation
    end

    def method_missing(meth, *args, &block)
      if /^[A-Z]/.match?(meth.to_s)
        require "debug"
        binding.break
        result = ole_obj.send(meth, *args, &block)
      else
        super(meth, *args, &block)
      end
    rescue => e
      binding.break
    end

    protected

    def ole_open_drawing(path, readonly: false, wait_time: 500, wait_interval: 0.5)
      ole = ole_obj.OpenDesignFile(windows_path(path), "ReadOnly" => readonly)
      wait_drawing_opened(wait_time, wait_interval)
      return ole if drawing_opened?

      raise DrawingError.new("drawing not opened in #{wait_time}", path) unless drawing_opened?
    end

    def load_constants(ole_obj)
      WIN32OLE.const_load(ole_obj, MSD) unless MSD.constants.size.positive?
    end

    def run_loop
      WIN32OLE_EVENT.message_loop while @run_loop
    end

    def stop_loop
      @run_loop = false
    end

    private

    def init_cad_input_queue
      ::Microstation::CadInputQueue.new(ole_obj.CadInputQueue, self)
    end
  end
end
