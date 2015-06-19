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
      l_drawing_path.parent.to_s
    end

    def to_h
      { template: template,
        output_dir: output_dir,
        name: drawing_name,
        locals: locals,
        tagsets: tagsets
      }
    end

    def drawing_name
      drawing_path.basename.to_s
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

end
