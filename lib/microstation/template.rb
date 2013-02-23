require 'erb'
require 'liquid'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'file_tests')
require File.join(File.dirname(__FILE__), 'errors')
require 'hash_maps'

module Microstation

  class Template

    LIQUID_REGEXP =  /{{([^}}]+)}}/

    include FileTests

    attr_reader :template, :filename

    def initialize(template,app = nil)
      unless microstation_drawing?(template)
        raise NonDGNFile
      end

      @template = template
      @filename = File.basename(template)
    end

    def close
      @app.quit
    end

    def with_tempfile(output)
      temp = Tempfile.new( File.basename(output))
      temp.close
      yield temp.path
      newname = outfile_name(output)
      FileUtils.mv(temp, newname)
      puts "Printed drawing #{newname}"
    end

    def render(context,locals={}, output)
      with_tempfile(output){|f| run_once(context,locals,f)}
    end

    def outfile_name(output_dir)
      File.join(output_dir, filename)
    end

    def app_render(app,context,locals={},ouput)
      with_tempfile{|f| run_with_app(app,context,locals,output)}
    end

    def add_binding(scope,locals={},&block)
      tagsets = locals.fetch(:tagsets,{})
      nlocals = normalize_hash(locals)
      nscope = normalize_hash(scope)
      nlocals = locals.merge(nscope)
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
      drawing.scan_text do |text|
        compiled = ::Liquid::Template.parse(text.to_s)
        new_text = compiled.render(locals) rescue text #binding.pry
        if new_text != text.to_s
          text.replace(new_text)
        end

      end
    end

    def entry_points
      @entry_points ||= get_entry_points
    end

    def get_entry_points
      result = []
      Microstation.scan_text(template) do |text|
        result << text.to_s if text.to_s  =~ /{{([^}}])+}}/
      end
      result
    end

    def keys_from_entry_points(entry_points)
      entry_points.reduce([]) do |result,text|
        text.scan(LIQUID_REGEXP).flatten.map{|t| t.strip}.each do |a|
          result << a
        end
        result.uniq
      end
    end

    def add_binding_erb(object)
      class << object
        def get_binding
          binding
        end
      end
    end

    def run_with_app(app, context,locals,file)
      app.new_drawing(file,@template) do |drawing|
        scope,tagsets = add_binding(context,locals)
        update_tagsets(drawing,tagsets)
        update_text(drawing,scope)
      end
    end

    def run_once(context,locals={},file)
      Microstation.run do |app|
        run_with_app(app,context,locals,file)
      end
    end


  end
end
