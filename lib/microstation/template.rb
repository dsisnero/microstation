require 'erb'
require 'liquid'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'extensions/hash')
module Microstation

  class Template

    def initialize(template,app = nil)
   #   @app = app || Microstation::App.new
      @template = template
    end

    def close
      @app.quit
    end

    def render(context,locals={}, output)
      temp = Tempfile.new('working')
      temp.close
      __run__(context,locals,temp.path)
      FileUtils.mv(temp,output)
      puts "Printed drawing #{output}"
    end

    def add_binding(scope,locals={},&block)
      tagsets = locals.delete(:tagsets)
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
        scope = scope.map_k{|k| k.to_s}
      end
      scope
    end

    def update_tagset(drawing,name,values)
      tagset = drawing.find_tagset(name)
      tagset.update(values)
    end

    def add_binding_erb(object)
      class << object
        def get_binding
          binding
        end
      end
    end

    def __run__(context,locals={},file)

      Microstation.run do |app|
        app.new_drawing(file,@template) do |drawing|
          scope,tagsets = add_binding(context,locals)
          tagsets.each do |tagset_name,values|
            tagset = drawing.find_tagset(tagset_name.to_s).first
            require 'pry'
            binding.pry
            tagset.update(values) if tagset
          end
          drawing.scan_text do |text|
            #   binding.pry if text =~ /usi_west|usi_east/
            compiled = ::Liquid::Template.parse(text.to_s)
            new_text = compiled.render(scope) rescue text #binding.pry
            if new_text != text.to_s
              text.replace(new_text)
            end

          end
        end
        #file
      end
    end

  end

end
