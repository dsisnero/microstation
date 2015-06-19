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

    attr_reader :template, :filename, :the_app

    def initialize(template,app = nil)
      check_is_dgn(template)
      @template = template
      @filename = File.basename(template)
      @the_app = app
    end

    def ensure_output_path(odir)
      path = Pathname(odir)
      path.mkpath unless  path.directory?
      path
    end

    def render(output_dir: default_outdir,
               locals: {},
               name: default_name,
               app: the_app,
               tagsets: {})
      output_path = ensure_output_path(output_dir)
      newname = output_path + name
      tmp_dgn = app ? render_into_tempfile(app,locals,tagsets) : render_once_into_tempfile(locals,tagsets)
      FileUtils.mv(tmp_dgn.path, newname.to_s)
      puts "Printed drawing #{newname}"
    end

    def default_outdir
      Pathname.getwd
    end

    def default_name
      filename
    end

    def normalize_hash(scope)
      scope = scope.to_h if scope.respond_to?(:to_h)
      if scope.kind_of? Hash
        scope = scope.map_keys{|k| k.to_s}
      end
      scope
    end

    def update_tagsets(drawing, ts_arg)
      return if ts_arg == []
      return if ts_arg == {}
      ts_arg = [ts_arg] if ts_arg.class == Hash
      drawing.update_tagsets(ts_arg)
    end

    def update_text(drawing,locals ={})
      return if locals == {}
      scope = add_binding(locals)
      do_update_text(drawing,scope)
    end

    def add_binding(locals={},&block)
      nlocals = normalize_hash(locals)
      nlocals['yield'] = block.nil? ? '' : yield
      nlocals['content'] = nlocals['yield']
      nlocals
    end

    def do_update_text(drawing,locals = {})
      drawing.scan_all_text do |m, text|
        compiled = ::Liquid::Template.parse(text.to_s)
        new_text = compiled.render(locals) rescue text #binding.pry
        if new_text != text.to_s
          text.replace(new_text)
        end

      end
    end

    def render_into_tempfile(app,locals={},tagsets={})
      tmpfile = Tempfile.new(filename)
      tmpfile.close
      app.new_drawing(tmpfile,@template) do |drawing|
        update_text(drawing,locals)
        update_tagsets(drawing,tagsets)
      end
      tmpfile
    end

    def render_once_into_tempfile(locals={}, tagsets= {})
      Microstation.run do |app|
        render_into_tempfile(app,locals,tagsets)
      end
    end

  end

end
