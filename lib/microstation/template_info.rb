module Microstation
  class TemplateInfo
    class TagSetMap
      def initialize(filter, block)
        @filter = filter
        @block = block
      end

      def call(tagsets)
        instances = tagsets.select(&filter)
        instances.map { |ti| block.call(ti) }
      end
    end

    LIQUID_REGEXP = /{{([^}}]+)}}/

    attr_reader :drawing, :placeholder_keys, :template, :tagsets, :locals, :drawing_path, :tagset_filter, :tagset_map

    def initialize(drawing, tagset_filter: nil, tagset_map: faa_map, visible: false)
      case drawing
      when ::Microstation::Drawing
        initialize_attributes(drawing)
        return
      when String, Pathname
        drawing_path = drawing
      else
        drawing_path = drawing.to_path
      end
      binding.pry
      ::Microstation::App.run(visible: visible) do |app|
        app.open_drawing(drawing_path) do |d|
          initialize_attributes(d)
        end
      end
      @tagset_filter = tagset_filter
      @tagset_map = tagset_map
      self
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
      # drawing.tagsets_in_drawing_to_hash
      drawing.tagsets_in_drawing_to_hash
    end

    def output_dir(l_drawing_path = @drawing_path)
      l_drawing_path.parent.to_s
    end

    def to_h
      filtered = if tagset_filter
                   tagsets.select { |ts| tagset_filter.call(ts) }
                 else
                   tagsets.dup
                 end
      mapped_tsets = filtered.map { |ts| tagset_map.call(ts) }
      { template: template,
        output_dir: output_dir,
        name: drawing_name,
        locals: locals,
        tagsets: mapped_tsets }
    end

    def default_filter
      ->(ts) { ts.name == 'faatitle' }
    end

    def before_locals(locals)
      locals
    end

    def map_tagset(mapname:, filter: tagset_name_filter, &block)
      @tagset_mappings[tname] = TagSetMap.new(filter, block)
    end

    def do_tagset_mappings
      @tagset_mappings.each do |ts_mapper|
        ts_mapper.call(tagsets)
        ti_instances = tagsets.select { |ts| ts['tag_name'] == k }
        ti_instances.each do |ti|
          ti.attributes.map
        end
      end
    end

    def faa_map
      lambda { |ts|
        if ts['tagset_name'] == 'faatitle'
          atts = ts['attributes']
          new_atts = atts.keep_if { |k, _v| faa_title_keys.include? k }
          ts['attributes'] = new_atts
          ts
        else
          ts
        end
      }
    end

    def faa_title_keys
      %w[microstation_id fac title1 title2 title3 subnam subttle appname appttl file dnnew jcnno city state]
    end

    def drawing_name
      drawing_path.basename.to_s
    end

    def yaml_filename
      drawing_path.basename.ext('yaml')
    end

    def dump(dir = output_dir)
      dir = Pathname(dir)
      File.open(dir + yaml_filename, 'w') { |f| f.puts to_yaml }
    end

    def to_yaml
      to_h.to_yaml
    end

    protected

    def entry_points(_drawing)
      @entry_points ||= get_entry_points
    end

    def get_entry_points(drawing)
      result = []
      drawing.scan_all_text do |m, text|
        binding.pry if text =~ /txt1/

        result << [m, text.to_s] if text.to_s =~ /{{([^}}])+}}/
      end
      binding.pry
      result
    end

    def keys_from_entry_points(entry_points = get_entry_points)
      entry_points.reduce([]) do |result, (_m, text)|
        text.scan(LIQUID_REGEXP).flatten.map { |t| t.strip }.each do |a|
          result << a
        end
        result.uniq
      end
    end

    def keys_to_h(keys = @placeholder_keys)
      keys.each_with_object({}) do |k, h|
        h[k] = ''
      end
    end
  end
end
