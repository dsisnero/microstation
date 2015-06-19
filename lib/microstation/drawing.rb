require_relative 'properties'
require_relative 'ts/drawing_extensions'
require_relative 'model'
require_relative 'errors'

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
    include TS::TagSetTrait
    include CriteriaCreationT

    attr_reader :app

    def initialize(app, ole)
      @app = app
      @ole_obj = ole
    end

    def ole_obj
      begin
        @ole_obj.ole_methods
        @ole_obj
      rescue => e
        binding.pry
        # @ole_obj = app.ole_open_drawing(self.path,read_only?)
      end
    end

    def active?
      ole_obj.IsActive
    end

    def cad_input_queue(&block)
      @app.cad_input_queue(&block)
    end

    def save_as_pdf(name: self.name , dir: self.dirname)
      out_name = Pathname(dir).expand_path + pdf_name(name)
      windows_name = app.windows_path(out_name)
      cad_input_queue do |q|
        q << "Print Driver #{pdf_driver}"
        q << "Print Papername ANSI D"
        q << "Print BOUNDARY FIT ALL"
        q << "Print ATTRIBUTES BORDER OUTLINE OFF"
        q << "Print Attributes Fenceboundary Off"
        q << "Print Execute #{windows_name}"
      end
      puts "saved #{windows_name}"
    end

    def scan_all(criteria,&block)
      if block
        scan_all_with_block(criteria,&block)
      else
        scan_all_into_hash(criteria)
      end
    end

    def scan_all_with_block(criteria=nil)
      result = {}
      each_model do |m|
        m.scan(criteria) do |r|
          yield m.name, r
        end
      end
    end

    def read_only?
      active_model_reference.IsReadOnly
    end

    def scan_all_into_hash(criteria=nil)
      result = {}
      each_model do |m|
        result[m.name] = m.scan(criteria)
      end
      result
    end

    def scan(criteria = nil, model = nil, &block)
      criteria = criteria || create_scan_criteria
      model = model || default_model_reference
      model.scan(criteria,&block)
    end

    def new_model(name,template = nil)
      template_ole = template ? template.ole_obj : app.ole_obj.ActiveDesignFile.DefaultModelReference
      el = app.ole_obj.ActiveDesignFile.Models.Add(template_ole,name,"Added ")
      m = Model.new(app,self,el)
      m
    end

    def tags_to_hash
      scan_all(tags_criteria)
    end

    def default_model_reference
      Model.new(app,self,ole_obj.DefaultModelReference)
    end

    def scan_text(model = nil,&block)
      model = get_model_for_scan(model)
      model.scan_text(&block)
    end

    def get_text(model = nil, &block)
      result = []
      model = get_model_for_scan(model)
      model.scan_text do |t|
        result << t.to_s
      end
      result
    end

    def get_all_text(&block)
      result = []
      scan_all_text do |m, t|
        result << t.to_s
      end
      result
    end

    def get_model_for_scan(model = nil)
      model = get_model_from_string(model) if model.is_a? String
      model ||= default_model_reference
      model
    end

    def get_model_from_string(model)
      ole = ole_obj.Models(string)
      Model.new(app,self,ole)
    end

    def scan_all_text(&block)
      scan_all(text_criteria,&block)
    end

    def scan_tags(model = nil,&block)
      model = get_model_for_scan(model)
      model.scan(tags_criteria,&block)
    end

    def scan_all_tags(&block)
      scan_all(tags_criteria,&block)
    end

    def modified_date
      ole_obj.DateLastSaved
    end
    #  alias_method :keywords , :keywords=x

    def dimensions
      eval_cexpression("tcb->ndices")
    end

    # def fullname
    #   ole_obj.FullName
    # end

    def two_d?
      dimensions == 2
    end

    def three_d?
      dimensions == 3
    end

    def name
      ole_obj.Name
    end

    def basename
      Pathname(name)
    end

    def dirname
      Pathname(ole_obj.Path).expand_path
    end

    def path
      dirname + basename
    end

    def revision_count
      ole_obj.DesignRevisionCount
    end

    def eval_cexpression(string)
      app.eval_cexpression(string)
    end

    def close
      ole_obj.Close rescue nil
    end

    def pdf_name(name = nil)
      name = self.name unless name
      return Pathname(name).sub_ext(".pdf")
    end

    def pdf_driver
      app.windows_path( (Microstation.plot_driver_directory + "pdf-bw.plt").to_s)
    end

    def each_model
      result = []
      ole_obj.Models.each do |el|
        model = Model.new(app,self, el)
        if block_given?
          yield model
        else
          result << model
        end
      end
      result
    end

    def models
      @models ||= each_model
    end

    def change_model(name)
      model = ole_obj.Models(name)
      puts "no model #{name}" unless model
      model.Activate
    end

    def model_names
      result = []
      ole_obj.Models.each do |el|
        result << el.name
        el = nil
      end
      result
    end

    def find_by_id(id)
      models.each do |model|
        el = model.find_by_id(id)
        return el if el
      end
    end

    def ole_line_element_klass
      @line_element ||= ole_classes.find{|c| c.name == '_LineElement'}
    end

    def ole_element_klass
      @element_class ||= ole_classes.find{|c| c.name == '_Element'}
    end

    def app_ole_obj
      @app_ole_obj ||= app.ole_obj
    end

    def typelib
      @typelib  ||= app_ole_obj.ole_typelib
    end

    def ole_classes
      @ole_classes ||= typelib.ole_classes
    end

    def create_line(p1,p2,el = nil)
      pt1 = to_point(p1)
      pt2 = to_point(p2)

      el = WIN32OLE_VARIANT::NoParam unless el
      begin
        ole = app.ole_obj.CreateLineElement2(el,pt1.ole_obj,pt2.ole_obj)
      rescue Exception => ex
        binding.pry
        return nil
      end
    end

    def to_point(pt)
      case pt
      when Array
        pt_a = pt.map{|p| p.to_f}
        x,y,z = pt_a
        z = 0 unless z
        app.Point3d(x,y,z)
      when Point3d
        pt
      end
    end

    # def create_tagset_instances(name,groups)
    #   ts = tagsets[name]
    #   ts.add_instance(group) if ts
    # end

    def save
      ole_obj.Save
    end

    def add_line(line_el)
      line_obj = line_el.ole_obj
      ole_obj.AddLine(line_obj)
    end

    def create_scanner(name,&block)
      app.create_scanner(name,&block)
    end

    def find_tagset_instances(ts)
      result = {}
      each_model do |m|
        instances = ts.find_instances_in_model(m)
        next if instances.empty?
        if block_given?
          yield m.name, instances
        else
          result[m.name] = instances
        end
      end
      result unless block_given?
    end

    def tagsets_in_drawing(&block)
      tagsets.each do |ts|
        find_tagset_instances(ts,&block)
      end
    end


    def find_tagset_with_block(name)
      ts = find_tagset(name)
      find_tagset_instances(ts) do |m, instances|
        instances.each do |inst|
          return inst if yield m, inst
        end
      end
      nil
    end

    def find_tagset_instances_by_name(name)
      ts = find_tagset(name)
      find_tagset_instances(ts).values.flatten
    end


    def find_tagset_instances_by_name_and_id(name,id)
      find_tagset_with_block(name){|m,i| i.microstation_id == id}
    end

    def update_tagset(name,h_local={})
      tsets = find_tagset_instances_by_name(name)
      case tsets.size
      when 0
        raise 'no tagset found'
      when 1
        ts = tsets.first
      else
        id = h_local.delete('microstation_id')
        raise MultipleUpdateError, "found #{tsets.size} instances for tagset #{name}; Need a microstation_id for hash" unless id
        ts = tsets.find{|ti| ti.microstation_id == id}
      end
      ts.update(h_local)
    end

    def update_tagsets(ts_arg)
      update_error() unless ts_arg.class == Array
      first_element = ts_arg.first
      if first_element.class == Hash
        if first_element.keys == ['model_name', 'instances']
          update_tagsets_from_template_structure(ts_arg)
        elsif
          first_element.keys == ['tagset_name','attributes']
          update_tagsets_from_array_name_structure(ts_arg)
        elsif first_element.keys.size == 1
          update_tagsets_from_simple_arg(ts_arg)
        end
      else
        update_error()
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

    def update_tagsets_from_array_name_structure(ts_arg)
      ts_arg.each do |tsname, atts|
        update_tagset(tname,atts)
      end
    end

    def update_tagsets_from_simple_arg(ts_arg)
      ts_arg.each do |inst_hash|
        inst_hash.each_pair do |name,atts|
          update_tagset(name,atts)
        end
      end
    end

    def tagsets_in_drawing2
      result = {}
      tagsets.each do |ts|
        each_model do |m|
          instances = ts.find_instances_in_model(m)
          if block_given?
            yield m.name, instances
          else
            result[m.name] = instances
          end
        end
      end
      result unless block_given?
    end

    def tagsets_in_drawing_to_hash
      result = []
      tagsets_in_drawing do |m, tiarray|
        result << { 'model_name' => m, 'instances'=> tiarray.map{|ti| ti.to_h}}
      end
      result
    end


  end

end
