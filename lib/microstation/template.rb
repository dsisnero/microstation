require 'erb'
require 'liquid'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'file_tests')
require File.join(File.dirname(__FILE__), 'errors')
require 'hash_maps'

module Microstation

  class TemplateInfo

    LIQUID_REGEXP =  /{{([^}}]+)}}/


    attr_reader :drawing,:placeholder_keys, :template, :tagsets,:locals,:drawing_path

    def initialize(drawing)
      case drawing
      when Microstation::Drawing
        initialize_attributes(drawing)
        return
      when String,Pathname
        drawing_path = drawing
      else
        drawing_path = drawing.to_path
      end
      Microstation::App.run do |app|
        app.open_drawing(drawing_path) do |d|
          initialize_attributes(d)
        end
      end
      return self
    end

    def initialize_attributes(drawing)
      @drawing_path = drawing.path
      entry_points = get_entry_points(drawing)
      @placeholder_keys = keys_from_entry_points(entry_points)
      @locals = keys_to_h(@placeholder_keys)
      @template = @drawing_path.to_s
      @tagsets = drawing_tagsets(drawing)
      @output_dir = output_dir(@drawing_path)
    end

    def drawing_tagsets(drawing)
      drawing.tagsets_in_drawing_to_hash
    end

    def output_dir(l_drawing_path = @drawing_path)
      l_drawing_path.basename.to_s
    end

    def to_h
      { template: template,
        output_dir: output_dir,
        locals: locals,
        tagsets: tagsets
      }
    end

    def yaml_filename
      drawing_path.basename.ext('yaml')
    end

    def dump(dir = output_dir)
      dir = Pathname(dir)
      File.open(dir + yaml_filename, 'w'){|f| f.puts self.to_yaml}
    end

    def to_yaml
      to_h.to_yaml
    end

    protected

    def entry_points(drawing)
      @entry_points ||= get_entry_points
    end

    def get_entry_points(drawing)
      result = []
      drawing.scan_all_text  do |m,text|

        result << [m, text.to_s] if text.to_s  =~ /{{([^}}])+}}/
      end
      result
    end

    def keys_from_entry_points(entry_points= get_entry_points)
      entry_points.reduce([]) do |result,(m,text)|
        text.scan(LIQUID_REGEXP).flatten.map{|t| t.strip}.each do |a|
          result << a
        end
        result.uniq
      end
    end

    def keys_to_h(keys= @placeholder_keys)
      keys.each_with_object({}) do |k,h|
        h[k] = ""
      end
    end

  end

  class TemplateRunner

    attr_reader :file, :h

    def initialize(file)
      @file = file
      @h = load(file)
    end

    def load(file)
      begin
        YAML.load(File.open(file))
      rescue ArgumentError => e
        puts "Could not parse YAML: #{e.message}"
      end
    end

    def locals
      h[:locals]
    end

    def tagsets
      h[:tagsets]
    end

    def output_dir
      h[:output_dir]
    end

    def template
      h[:template]
    end

    def run
      template = Template.new(template)
      template.render(output_dir: output_dir,
                      locals: locals,
                      name: name
                      )
    end

  end

  class Template

    LIQUID_REGEXP =  /{{([^}}]+)}}/

    include FileTests

    attr_reader :template, :filename, :app

    def initialize(template,app = nil)
      check_is_dgn(template)
      @template = template
      @filename = File.basename(template)
      @app = app
    end

    def ensure_output_path(odir)
      path = Pathname(odir)
      path.mkpath unless  path.directory?
      path
    end

    def render(output_dir: default_outdir,
               locals: {}, name: default_name, the_app: app)
      output_path = ensure_output_path(output_dir)
      newname = output_path + name
    #  binding.pry
      tmp_dgn = the_app ? render_into_tempfile(app,locals) : render_once_into_tempfile(locals)
      FileUtils.mv(tmp_dgn.path, newname.to_s)
      puts "Printed drawing #{newname}"
    end

    def default_outdir
      Pathname.getwd
    end

    def default_name
      filename
    end


    def add_binding(locals={},&block)
      tagsets = locals.fetch(:tagsets,{})
      nlocals = normalize_hash(locals)
      nlocals['yield'] = block.nil? ? '' : yield
      nlocals['content'] = nlocals['yield']
      [nlocals,tagsets]
    end

    def normalize_hash(scope)
      scope = scope.to_h if scope.respond_to?(:to_h)
      if scope.kind_of? Hash
        scope = scope.map_keys{|k| k.to_s}
      end
      scope
    end

    def update_tagsets(drawing,tagsets)
      tagsets.each do |tagset_name,values|
        update_tagset(drawing, tagset_name, values)
      end
    end

    def update_tagset(drawing,name,values)
      tagset = drawing.find_tagset(name)
      tagset.update(values) if tagset
    end

    def update_text(drawing,locals ={})
      drawing.scan_all_text do |m, text|
        #binding.pry
        compiled = ::Liquid::Template.parse(text.to_s)
        new_text = compiled.render(locals) rescue text #binding.pry
        if new_text != text.to_s
          text.replace(new_text)
        end

      end
    end

    # def entry_points
    #   @entry_points ||= get_entry_points
    # end

    # def get_entry_points
    #   result = []
    #   Microstation.scan_text(template) do |text|
    #     result << text.to_s if text.to_s  =~ /{{([^}}])+}}/
    #   end
    #   result
    # end

    # def keys_from_entry_points(entry_points)
    #   entry_points.reduce([]) do |result,text|
    #     text.scan(LIQUID_REGEXP).flatten.map{|t| t.strip}.each do |a|
    #       result << a
    #     end
    #     result.uniq
    #   end
    # end

    def add_binding_erb(object)
      class << object
        def get_binding
          binding
        end
      end
    end

    def render_into_tempfile(app,locals)
      tmpfile = Tempfile.new(filename)
      tmpfile.close
      app.new_drawing(tmpfile,@template) do |drawing|
        scope,tagsets = add_binding(locals)
        update_tagsets(drawing,tagsets)
        update_text(drawing,scope)
      end
      tmpfile
    end

    def render_once_into_tempfile(locals={})
      Microstation.run do |app|
        render_into_tempfile(app,locals)
      end
    end


  end

end
