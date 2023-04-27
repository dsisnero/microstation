# require File.join(File.dirname(__FILE__) , 'attributes')
require File.join(File.dirname(__FILE__), "ts/instance")
require File.join(File.dirname(__FILE__), "ts/attribute")

module Microstation
  module OleCollection
    def initialize(_ole_col)
      @ole_obj = ole
    end

    def [](name)
      ole_obj(name)
    rescue
      nil
    end

    def each
      @ole_obj.each do |ts|
        yield wrap(ts)
      end
    end

    def wrap(ts)
      ts
    end
  end

  class TagSets
    include Enumerable

    attr_reader :drawing, :ole_obj

    def initialize(drawing, ole)
      raise if ole.nil?

      @drawing = drawing
      @ole_obj = ole
    end

    def init_ts
      result = []
      @ole_obj.each do |ts|
        result << TagSet.new(drawing, ts)
      end
      result
    end

    def to_s
      "Tagsets: #{tagsets}"
    end

    def reset
      @tagsets = nil
      @drawing.reset_tagset_instances
    end

    def names
      map { |ts| ts.name }
    end

    def tagsets
      @tagsets ||= init_ts
    end

    def each(&block)
      tagsets.each(&block)
    end

    def find(name)
      return nil if empty?

      tagsets.detect { |ts| ts.name == name }
    end

    def last
      tagsets[-1]
    end

    def [](name)
      find(name)
    end

    def remove(name)
      ts = find(name)
      if ts
        begin
          @ole_obj.Remove(name)
        rescue
          nil
        end
        ts.close
        ts = nil
      end
      reset
    end

    def empty?
      tagsets.empty?
    end

    def create(name)
      raise if self[name]

      ole = begin
        @ole_obj.add(name)
      rescue
        binding.pry
      end
      # ts = Tagset.new(ole)
      # yield definer if block_given?
      reset
      ts = self[name]
      raise if ts.nil?

      yield ts if block_given?
      ts
    end

    def size
      tagsets.size
    end
  end

  # class Definer

  #   attr_reader :tagset

  #   def initialize(tagset)
  #     @tagset = tagset
  #   end

  #   def add_attribute(name,type,prompt: name, is_hidden: false, is_constant: false, default: nil)
  #     ole_td = create_ole_definition(name, type)
  #     td = TS::Attribute.new(ole_td)
  #     td.prompt = prompt
  #     td.hidden = is_hidden
  #     td.constant = is_constant
  #     td.default = default
  #     #td.hidden = td.fetch(:is_hidden)
  #     yield td if block_given?
  #     td
  #   end

  #   private

  #   def tag_definitions
  #     tagset.ole_tag_definitions
  #   end

  #   def close

  #   end

  #   def ole_type(type)
  #     TS::Attribute.tag_type(type)
  #   end

  #   def create_ole_definition(name,type)
  #     tag_definitions.Add(name,ole_type(type))
  #   end

  # end

  class Definition
    attr_reader :tagset

    def initialize(tagset)
      @tagset = tagset
    end

    def add_attribute(*args, **kwargs)
      td = create_attribute(*args, **kwargs)
      yield td if block_given?
      reset
      td
    end

    # def definer
    #   @definer ||= Definer.new(tagset)
    # end

    def attributes
      @attributes ||= init_definitions
    end

    def attribute_names
      attributes.map { |a| a.name }
    end

    def reset
      @attributes = nil
    end

    def close
      attributes.each { |a| a.close }
    end

    def [](name)
      attributes.find { |d| d.name == name }
    end

    protected

    # def ole_tag_definitions
    #   tagset.ole_tag_definitions
    # end

    def ole_tag_definitions
      @tagset.ole_obj.TagDefinitions
    end

    def create_ole_definition(name, type)
      ole_tag_definitions.Add(name, ole_type(type))
    end

    def init_definitions
      results = []
      ole_tag_definitions.each do |ole|
        results << TS::Attribute.new(ole, {definer: self})
      end
      results
    end

    def create_attribute(name, type, prompt: name, is_hidden: false, is_constant: false, default: nil)
      ole_td = create_ole_definition(name, type)
      td = TS::Attribute.new(ole_td)
      td.prompt = prompt
      td.hidden = is_hidden
      td.constant = is_constant
      td.default = default
      yield td if block_given?
      td
    end

    def ole_type(type)
      TS::Attribute.tag_type(type)
    end
  end

  class TagSet
    attr_reader :ole_obj, :instances, :drawing

    def initialize(drawing, ole)
      @drawing = drawing
      @ole_obj = ole
      @instances = nil
    end

    def add_attribute(name, type, **options, &block)
      ts = definition.add_attribute(name, type, **options, &block)
    end

    # def definer
    #   @definer ||= Definer.new(self)
    # end

    def add_instance(array)
      @instances << TS::Instance.new(self, array)
    end

    def create_instance(base_element_id, tags, model)
      return unless @instaces.nil?

      @instance = []
      ti = TS::Instances.new(self, base_element_id, tags, model)
      @instances << ti
      ti
    end

    def create_instance(id, elements, model)
      @instances = [] if @instances.nil?
      ti = TS::Instance.new(self, id, elements, model)
      @instances << ti
      ti
    end

    # def instances(drawing = Microstation.app.current_drawing)
    #   @instances = create_instances(drawing.scan_tags)
    # end

    # def find_instances_in_model(model)
    #   result = create_instances(model.scan_tags)
    #   instances[model.name] = result
    #   result
    # end

    def instances
      if @instances.nil? && find_tagset_instances_not_called?
        @instances = @drawing.create_tagset_instances(ts_name: name).to_a
      end
      raise if find_tagset_instances_not_called?

      @instances.nil? ? [] : @instances
    end

    # def create_instances_from_drawing(drawing)
    #   mytags = tags_for_self(tags)
    #   grouped = grouped_tags_to_host(mytags)
    #   grouped.map{|group| create_instance(group)}
    # end

    # def all_tags_in_drawing
    #   Microstation.app.current_drawing.scan_tags
    # end

    def close
      @ole_obj = nil
    end

    def name
      @ole_obj.name
    end

    def to_s
      "TagSet: #{name}"
    end

    def ==(other)
      @ole_obj == other.ole_obj
    end

    def attribute_names
      definition.attribute_names
    end

    def attributes
      definition.attributes
    end

    def [](name)
      definition[name]
    end

    protected

    def definition
      @definition ||= Definition.new(self)
    end

    def reset
      @tag_definitions = nil
    end

    def find_tagset_instances_not_called?
      !drawing.find_tagset_instances_called?
    end

    # def create_ole_definition(name,type)
    #   ole_tag_definitions.Add(name, ole_type(type))
    # end

    # protected

    # def tags_for_self(tags)
    #   tags.select{|t| t.tagset_name == name}
    # end

    # def grouped_tags_to_host(tags)
    #   tags.group_by{|t| t.base_element_id}
    # end

    # def ole_tag_definitions
    #   @ole_obj.TagDefinitions
    # end
  end
end
