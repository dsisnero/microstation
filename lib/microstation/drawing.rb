require_relative 'properties'
require_relative 'tag_set_trait'
require_relative 'model'
require_relative 'errors'
require_relative 'scan_trait'
require 'liquid'
# /
# // MessageId: DISP_E_PARAMNOTFOUND
# //
# // MessageText:
# //
# // Parameter not found.
# //
# ##define DISP_E_PARAMNOTFOUND       _HRESULT_TYPEDEF_(0x80020004L)
module Microstation
  class Drawing
    include Properties
    include TagSetTrait
    include ScanTrait

    attr_reader :app

    #
    # Initialize drawing
    #
    # @param app [<Application>] the app instance
    # @param ole [<WIN32OLIE>] the ole object returned from app.ole_obj
    #
    def initialize(app, ole)
      @app = app
      @ole_obj = ole
      @find_tagset_instances_called = false
      @app.register_handler('ISaveAsEvents_AfterSaveAs') do |*_args|
        @drawing_saved = true
      end
    end

    def find_tagset_instances_called?
      @find_tagset_instances_called
    end

    def reset_tagset_instances
      @find_tagset_instances_called = false
    end

    # @return [Boolean] is the drawing active?
    def active?
      ole_obj.IsActive
    end

    # @yield [Microstation::CadInputQueue] yields a cad_input_queue to
    # the block
    def cad_input_queue(&block)
      @app.cad_input_queue(&block)
    end

    # copy the drawing
    # @param [String] name of the file
    # @param [String,Pathname] dir
    def copy(name: nil, dir: nil)
      if dir.nil?
        lname = name || copy_name
        dir_path = dirname
      else
        lname = name || self.name
        dir_path = Pathname(dir)
      end
      copy_path = dir_path + lname
      FileUtils.copy path.to_s, copy_path.to_s, verbose: true
    end

    # save the drawing as a pdf file
    # if the name or directory is given it uses
    # those params. If not it uses the drawing name
    # and the drawing directory
    # @param name - the name of the file
    # @param dir - the directory to save the drawing
    # @return [void]
    def save_as_pdf(name: nil, dir: nil)
      out_name = pdf_path(name: name, dir: dir)
      windows_name = app.windows_path(out_name)
      loop do
        print_pdf(windows_name)
        break if out_name.file?
      end
      puts "saved #{windows_name}"
    end

    #
    # Save the drawing under a different name
    #
    # @param [String,Pathname] name name to change to
    # @param [Boolean] overwrite - whether to overwrite if file exists
    # @param [<Type>] format <description>
    #
    # @return [void]
    #
    def save_as(name, overwrite: false, format: 0)
      @drawing_saved = false
      path = Pathname(name).expand_path
      wpath = app.windows_path(name)
      begin
        ole_obj.SaveAs(wpath, overwrite, format)
        wait_save_event(10)
        raise 'drawing not saved in 10 seconds' unless @drawing_saved
      rescue StandardError => e
        binding.pry
      end
    end

    def wait_save_event(_secs, interval = 0.5)
      elapsed = 0
      while !@drawing_saved && elapsed <= 5
        elapsed += interval
        sleep(interval)
        WIN32OLE_EVENT.message_loop
      end
    end

    # @return [Boolean] is the drawing readonly?
    def read_only?
      active_model_reference.IsReadOnly
    end

    # Scan the drawing.  It takes a criteria and an optional model
    # scan the drawing
    # @param [Scan::Criteria] criteria - the criteria
    # @param [Model]
    # @criteria [Scan::Criteria]
    # @yield
    def scan_model(criteria, model: default_model_reference, &block)
      criteria ||= create_scan_criteria
      model ||= default_model_reference
      model.scan_model(criteria, &block)
    end

    # scans all the drawing models with criteria
    # @param [Scan::Criteria] criteria
    #
    # calls scan_all_with_block
    # calls scal_all_with_hash
    def scan_all(criteria)
      return to_enum(__callee__, criteria) unless block_given?

      each_model do |m|
        m.scan_model(criteria) do |r|
          if block_given?
            yield r
          else
            result << r
          end
        end
      end
    end

    def get_text
      result = []
      scan_text do |te|
        if block_given?
          yield te.to_s
        else
          result << te.to_s
        end
      end
      result
    end

    # scan all text and text regions in all
    # models
    # @yield [String] text that is found
    def scan_text(&block)
      scan_all(text_criteria, &block)
    end

    # scan all tags in drawing and
    # @yield [Tag] to the block
    def scan_tags(&block)
      scan_all(tags_criteria, &block)
    end

    # scan all cells in drawing and
    # @yield [Cell] to the block
    def scan_cells(&block)
      scan_all(cells_criteria, &block)
    end

    def scan_text_in_cells(&block)
      scan_cells do |c|
        c.text_elements(&block)
      end
    end

    # @return [Model] the ole.DefaultModelReference
    def default_model_reference
      Model.new(app, self, ole_obj.DefaultModelReference)
    end

    def active_model
      return nil unless has_active_model?

      Model.new(app, self, app_ole_obj.ActiveModelReference)
    end

    # @return [Boolean] true if drawing has an active model
    def has_active_model?
      app_ole_obj.HasActiveModelReference
    end

    # @return [Date] date last modified
    def modified_date
      ole_obj.DateLastSaved
    end
    #  alias_method :keywords , :keywords=x

    def dimensions
      eval_cexpression('tcb->ndices')
    end

    # def fullname
    #   ole_obj.FullName
    # end

    # @return [Boolean] true if a 2d drawing
    def two_d?
      dimensions == 2
    end

    # @return [Boolean] true if a 3d drawing
    def three_d?
      dimensions == 3
    end

    # @return [String] the name of the drawing
    def name
      ole_obj.Name
    end

    # @return [Pathname] the name as Pathname
    def basename
      Pathname(name)
    end

    # @return [Pathname] the directory of the file
    def dirname
      Pathname(ole_obj.Path).expand_path
    end

    # @return [Pathname] the complete path of file
    def path
      dirname + basename
    end

    def revision_count
      ole_obj.DesignRevisionCount
    end

    def eval_cexpression(string)
      app.eval_cexpression(string)
    end

    # Close the drawing
    def close
      @drawing_closed = true
      begin
        ole_obj.Close
      rescue StandardError
        nil
      end
      @ole_obj = nil
    end

    def drawing_closed?
      @drawing_closed
    end

    # Return the pdf name for the drawing.
    #
    # If a name is provided use the name provided otherwise use the drawing name
    #
    # @param name [String, nil] @return a Pathname from the name or drawing name
    def pdf_name(name = nil)
      name ||= self.name
      Pathname(name).sub_ext('.pdf')
    end

    def pdf_driver
      app.windows_path((::Microstation.plot_driver_directory + 'pdf-bw.plt').to_s)
    end

    def pen_table
      app.windows_path((::Microstation.plot_driver_directory + 'wmbw.tbl'))
    end

    # iterate through each model in the drawing
    # and yield them
    # @yield [Model] model
    def each_model
      result = []
      ole_obj.Models.each do |el|
        model = model_from_ole(el)
        if block_given?
          yield model
        else
          result << model
        end
      end
      result unless block_given?
    end

    # Create a new model
    # @param [String] name - the name of the model
    # @param [String] template - the template to use for the model
    def new_model(name, template = nil)
      template_ole = template ? template.ole_obj : app.ole_obj.ActiveDesignFile.DefaultModelReference
      el = app.ole_obj.ActiveDesignFile.Models.Add(template_ole, name, 'Added ')
      model_from_ole(el).activate
    end

    # Active a model
    # @param name [String] a
    def activate_model(name)
      model = find_model(name)
      model&.activate
    end

    # Find the model in the drawing
    # @param [String] name - the name of the model
    # @return [Model, nil] the model or nil if not found
    def find_model(name)
      ole = ole_obj.Models(name)
      model_from_ole(ole)
    rescue StandardError
      puts "model #{name} not found"
      nil
    end

    # @return [Boolean] true if drawing has more than 1 model
    def multiple_models?
      ole_obj.Models.Count > 1
    end

    def models
      @models ||= each_model
    end

    def get_selected_elements
      return [] unless has_active_model?

      active_model.get_selected_elements
    end

    def get_selected_text
      active_model.get_selected_text
    end

    def get_matching_text(re, &block)
      active_model.get_matching_text(re, &block)
    end

    def change_text_suffix(reg, offset)
      active_model.change_text_suffix(reg, offset)
    end

    # activate the model with name
    # param name [String] name the name of the model
    # activate the model found and return the model
    # @return [Model, nil]
    def change_model(name)
      model = find_model(name)

      return unless model

      model.activate
    end

    alias activate_model change_model

    #
    # Returns the model names
    #
    # @return [Array<String>] the names of the models
    def model_names
      result = []
      ole_obj.Models.each do |el|
        result << el.name
      end
      result
    end

    # Iterates through all the models and finds the
    # ole_el with id
    # @param [String] -id
    # @return Element
    def find_by_id(id)
      models.each do |model|
        el = model.find_by_id(id)
        return el if el
      end
      nil
    end

    def zoom_to_element(target, n_view)
      return nil unless target.graphical?

      zoom = 4
      range = target.Range
      oview = app_ole_obj.ActiveDesignFile.Views.Item(n_view)
      range_diff = app_ole_obj.Point3dSubtract(range.High, range.Low)
      extent = app_ole_obj.Point3dScale(range_diff, zoom)

      oview_origin = app_ole_obj.Point3dSubtract(range.Low, app_ole_obj.Point3dScale(extent, 0.5))
      oview.Origin = oview_origin
      oview.Extents = extent
      oview.Redraw
      target.IsHighlighted = true
    end

    #
    # Save the drawing
    #
    # @return [void]
    #
    def save
      ole_obj.Save
    end

    def add_element(line)
      active_model.add_element(line)
    end

    def create_scanner(name, &block)
      app.create_scanner(name, &block)
    end

    # used
    def create_tagset_instances_bak
      result = []
      @find_tagset_instances_called = true
      filtered = if block_given?
                   get_tagsets_in_drawing_hash.select(&filter)
                 else
                   get_tagsets_in_drawing_hash
                 end
      binding.pry
      filtered.map do |h|
        element_id = h[:base_element_id]
        result << tagset.create_instance(element_id, h[:tags], h[model])
      end
      result
    end

    def create_tagset_instances(ts_name: nil, base_element_id: nil)
      result = []
      @find_tagset_instances_called = true
      get_tagsets_in_drawing_hash(ts_name: ts_name, base_element_id: base_element_id) do |h|
        result << create_tagset_instance_from_tagset_hash(h)
      end
      result
    end

    def tagsets_in_drawing
      @tagset_instances ||= create_tagset_instances
    end

    def tagsets_in_drawing!
      @tagset_instances = nil
      tagsets_in_drawing
    end

    def create_tagset_instance_from_tagset_hash(h)
      ts = tagsets[h[:name]]
      ts.create_instance(h[:base_element_id], h[:tags], h[:model])
    end

    def save_tagsets_to_file(name)
      require 'json'
      ::File.open(name, 'w') { |f| f.write get_tagsets_in_drawing_hash.to_a.to_json }
    end

    # used
    def get_tagsets_in_drawing_hash(ts_name: nil, base_element_id: nil, &block)
      return to_enum(__callee__, ts_name: ts_name, base_element_id: base_element_id) unless block_given?

      each_model do |m|
        m.get_tagsets_in_model_hash(ts_name: ts_name, base_element_id: base_element_id, &block)
      end
    end

    def select_tagset_instances_by_name(name)
      create_tagset_instances(ts_name: name)
    end

    def find_tagset_instance_by_name(name)
      create_tagset_instances(ts_name: name).first
    end

    def find_tagset_instance_by_name_and_id(name, id)
      create_tagset_instances(ts_name: name, base_element_id: id).first
    end

    def find_tagsets
      results = []
      each_model do |m|
        m.find_tagsets.each do |ts|
          if block_given?
            yield ts
          else
            results << ts
          end
        end
      end
      return results unless block_given?
    end

    def update_tagset(name, h_local = {})
      tset_instances = select_tagset_instances_by_name(name)
      case tset_instances.size
      when 0
        raise 'no tagset found'
      when 1
        ts = tset_instances.first
        ts.update(h_local)
      else
        if h_local.instance_of?(Array) && h_local.all? { |l| l.instance_of?(Hash) }
          h_local.each do |update_hash|
            ts = find_tagset_instance_from_hash(tset_instances, update_hash)
            ts.update(update_hash)
          end
        elsif h_local.instance_of?(Hash)
          ts = find_tagset_instance_from_hash(tset_instances, h_local)
          ts.update(h_local)
        else
          raise ArgumentError, "don't know how to update tagset"
        end
      end
    end

    def find_tagset_instance_from_hash(ti_array, h_local)
      id = h_local.fetch('microstation_id', :not_found)
      if id == :not_found || id.nil?
        name = ti_array.first.name

        raise MultipleUpdateError,
              "found #{ti_array.size} instances for tagset #{name}; Need a microstation_id for hash"
      end
      ts = ti_array.find { |ti| ti.microstation_id == id }
    end

    def update_tagsets(ts_arg)
      return if ts_arg == []
      return if ts_arg == {}

      ts_array = [ts_arg] if ts_arg.instance_of?(Hash)
      ts_array.each do |hash_pair|
        update_tagset(hash_pair.keys[0], hash_pair.values[0])
      end
    end

    def update_error
      raise ArgumentError, 'Argument must be an array of hashes'
    end

    def update_tagsets_from_template_structure(ts_arg)
      ts_arg.each do |h|
        inst_array = h['instances']
        inst_array.each do |ts_hash|
          update_tagset(ts_hash['tagset_name'], ts_hash['attributes'])
        end
      end
    end

    #
    # returns the internal ole_obj
    #
    # @return [WIN32OLE]
    #
    def ole_obj
      is_ok = true
      begin
        @ole_obj.Name
      rescue StandardError => e
        is_ok = false
      end

      binding.pry unless is_ok || drawing_closed?

      @ole_obj
    end

    def find_line_element
      line = nil
      scan_lines do |el|
        line = el if el.microstation_type == MSD::MsdElementTypeLine
      end
      line
    end

    def to_ole_point3d(pt)
      app.to_ole_point3d(pt)
    end

    def create_line(p1, p2, el = nil)
      #  el = find_line_element
      pt1, pt2 = [p1, p2].map { |p| to_ole_point3d(p) }
      el ||= WIN32OLE_VARIANT::Nothing
      el = el.ole_obj if el.respond_to? :ole_obj
      begin
        ole = app.ole_obj.CreateLineElement2(el, pt1, pt2)
        return nil unless ole

        app.wrap(ole)
      rescue Exception => e
        puts e.message bb
        puts "class: #{el.class}"
        nil
      end
    end

    def to_point(pt)
      app.to_point(pt)
    end

    protected

    def normalize_update_hash(h)
      h = h.to_h if h.respond_to?(:to_h)
      h = h.map_keys { |k| k.to_s } if h.is_a? Hash
      h
    end

    def print_pdf(windows_path)
      cad_input_queue do |q|
        q << "Print Driver #{pdf_driver}"
        q << 'Print Papername ANSI D'
        q << 'Print BOUNDARY FIT ALL'
        q << 'Print ATTRIBUTES BORDER OUTLINE OFF'
        q << 'Print Attributes Fenceboundary Off'
        q << "Print pentable attach #{pen_table}"
        q << 'Print colormode monochrome'
        q << "Print Execute #{windows_path}"
      end
    end

    def get_model_for_scan(model = nil)
      model = find_model(model) if model.is_a? String
      model ||= active_model || default_model_reference
      model
    end

    def model_from_ole(ole)
      Model.new(app, self, ole)
    end

    def copy_name(backup_str = '.copy')
      lname = name.dup
      ext = File.extname(lname)
      name = "#{File.basename(lname, ext)}#{backup_str}#{ext}"
    end

    def pdf_path(name: nil, dir: nil)
      name ||= self.name
      dir = Pathname(dir || dirname).expand_path
      dir.mkpath unless dir.directory?
      dir + pdf_name(name)
    end

    def ole_line_element_klass
      @line_element ||= ole_classes.find { |c| c.name == '_LineElement' }
    end

    def ole_element_klass
      @element_class ||= ole_classes.find { |c| c.name == '_Element' }
    end

    def app_ole_obj
      @app_ole_obj ||= app.ole_obj
    end

    def typelib
      @typelib ||= app_ole_obj.ole_typelib
    end

    def ole_classes
      @ole_classes ||= typelib.ole_classes
    end
  end
end
