#require File.join(File.dirname(__FILE__) , 'attributes')
require File.join(File.dirname(__FILE__), 'ts/instance')
require File.join(File.dirname(__FILE__), 'ts/attribute')
module Microstation


  module OleCollection

    def initialize(ole_col)
      @ole_obj = ole
    end

    def [](name)
      ole_obj(name) rescue nil
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

    def initialize(ole)
      @ole_obj = ole
    end

    def init_ts
      result = []
      @ole_obj.each do |ts|
        result << TagSet.new(ts)
      end
      result
    end

    def to_s
      "Tagsets: #{tagsets.to_s}"
    end

    def reset
      @tagsets = nil
    end

    def tagsets
      @tagsets ||= init_ts
    end

    def each
      tagsets.each do |obj|
        yield obj
      end
    end

    def find(name)
      return nil if empty?
      tagsets.detect{|ts| ts.name == name}
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
        @ole_obj.Remove(name) rescue nil
        ts.close
        ts = nil
      end
      @tagsets = init_ts
    end

    def empty?
      tagsets.empty?
    end

    def create(name)
      raise if self[name]
      ole = @ole_obj.add(name)
      definer = Definer.new(ole)
      yield definer if block_given?
      @tagsets = init_ts
      ts = self[name]
      raise if ts.nil?
      definer = nil
      ts
    end

    def size
      tagsets.size
    end

  end

  class Definer

    attr_reader :tagset

    def initialize(tagset)
      @tagset = tagset
    end


    def add_attribute(name,type,options = {})
      ole_td = create_ole_definition(name, type)
      td = TS::Attribute.new(ole_td)
      td.prompt = options[:prompt] || name
      td.hidden = options[:is_hidden]
      td.constant = options[:is_constant] || false
      td.default = options[:default] if options[:default]
      #td.hidden = td.fetch(:is_hidden)
      yield td if block_given?
      td
    end

    private

    def tag_definitions
      tagset.ole_tag_definitions
    end

    def close

    end

    def ole_type(type)
      TS::Attribute.tag_type(type)
    end

    def create_ole_definition(name,type)
      tag_definitions.Add(name,ole_type(type))
    end

  end

  class Definition

    attr_reader :tagset

    def initialize(tagset)
      @tagset = tagset
    end

    def add_attribute(name,type,options={})
      td = definer.add_attribute(name,type,options)
      reset
      td
    end

    def definer
      @definer ||= Definer.new(tagset)
    end

    def ole_tag_definitions
      tagset.ole_tag_definitions
    end

    def init_definitions
      results = []
      ole_tag_definitions.each do |ole|
        results << TS::Attribute.new(ole, {definer: self})
      end
      results
    end

    def attributes
      @attributes ||= init_definitions
    end

    def attribute_names
      attributes.map{|a| a.name}
    end

    def reset
      @attributes = nil
    end

    def close
      attributes.each{| a| a.close}
    end

    def [](name)
      attributes.find{|d| d.name == name}
    end

  end

  class TagSet

    attr_reader :ole_obj

    attr_reader :instances

    def initialize(ole)
      @ole_obj = ole
      @instances = {}
    end

    def add_attribute(name,type,options={})
      definition.add_attribute(name,type,options)
    end

    def definer
      @definer ||= Definer.new(self)
    end

    def reset
      @tag_definitions = nil
    end

    def add_instance(array)
      @instances << TS::Instance.new(self,array)
    end

    def create_instance(group)
      id, elements = group
      TS::Instance.new(self,id,elements)
    end

    # def instances(drawing = Microstation.app.current_drawing)
    #   @instances = create_instances(drawing.scan_tags)
    # end

    def find_instances_in_model(model)
      result = create_instances(model.scan_tags)
      instances[model.name] = result
      result
    end

    def create_instances(tags)
      mytags = tags_for_self(tags)
      grouped = grouped_tags_to_host(mytags)
      grouped.map{|group| create_instance(group)}
    end

    def all_tags_in_drawing
      Microstation.app.current_drawing.scan_tags
    end

    def definition
      @definition ||= Definition.new(self)
    end

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

   # protected

     def tags_for_self(tags)
      tags.select{|t| t.tagset_name == name}
    end

    def grouped_tags_to_host(tags)
      tags.group_by{|t| t.base_element_id}
    end

      def ole_tag_definitions
      @ole_obj.TagDefinitions
    end


  end

end
