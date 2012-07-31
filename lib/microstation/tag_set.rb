require File.join(File.dirname(__FILE__) , 'attributes')
module Microstation

  class TagSetClass

    include Virtus


    def self.find_in_drawing
      # drawing.scan_graphical
      # if graphical.has_tagset
      #   return element
    end

    def to_ole
    end

    def from_ole
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

    def [](name)
      return nil if empty?
      tagsets.find{|ts| ts.name == name}
    end

    def remove(name)
      ts = tagsets.delete_if{|t| t.name == name}
      ts.each do |ts|
        ts.close
        ts = nil
      end

    end

    def empty?
      tagsets.empty?
    end

    def create(name)
      raise if self[name]
      ole = @ole_obj.add(name)
      @tagsets = init_ts
      ts = self[name]
      raise if ts.nil?
      ts
    end

    def size
      tagsets.size
    end

  end

  class TagSet

    attr_reader :ole_obj

    def initialize(ole)
      @ole_obj = ole
    end

    def ole_tag_definitions
      @tag_definitions = @ole_obj.TagDefinitions
    end

    def reset
      @tag_definitions = nil
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

    def each
      return to_enum unless block_given?
      ole_tag_definitions.each do |ole|
        yield TagDefinition.new(self,ole)
      end
    end

    def [](name)
      self.definitions.find{|d| d.name == name}
    end

    def make_mapper(name = self.name)
      atts = self.definitions
      m = Class.new(TagSetClass) do
        atts.each do |td|
          attribute(td.name, td.type, td.attrib_options)
        end
      end
    end

    def definitions
      result = []
      each do |td|
        result << td
      end
      result
    end

    def create_ole_definition(name,type)
      ole_type =  TagDefinition.tag_type(type)
      ole_tag_definitions.Add(name,ole_type)
    end


    def definition(name,type,options = {})
      ole_td = create_ole_definition(name, type)
      td = TagDefinition.new(self,ole_td)
      td.prompt = options[:prompt] || name
      td.hidden = options[:is_hidden]
      td.constant = options[:is_constant] || false
      td.default = options[:default] if options[:default]
      #td.hidden = td.fetch(:is_hidden)
      yield td if block_given?
      td
    end

  end



  class TagDefinition

    attr_reader :ole_obj


    #   msdTagTypeCharacter 1 (&H1)
    # msdTagTypeShortInteger 2 (&H2)
    # msdTagTypeLongInteger 3 (&H3)
    # msdTagTypeDouble 4 (&H4)
    # msdTagTypeBinary 5 (&H5)


    TYPES = {
      1 => String,
      2 => Integer,
      3 => Integer,
      4 => Float,
      #   5 => Binary
    }

    RUBY_TO_MS = TYPES.invert

    def self.tag_type(type)
      RUBY_TO_MS[type]
    end

    def att_type
      TYPES[type]
    end

    def initialize(tagset,ole)
      @tagset = tagset
      @ole_obj = ole
    end

    def name
      @ole_obj.name
    end

    def name=(val)
      @ole_obj.Name = val
    end

    def tagset_name
      @tagset.name
    end

    def options_for_attribute
      options = {}
      options[:is_hidden] = true if hidden?
      options[:prompt] = prompt if prompt
      options[:default] = default_value
      options[:readonly] = true if constant?
    end

    def to_s
      "TagDefinition: #{name}"
    end

    def constant?
      @ole_obj.IsConstant
    end

    def constant=(constant)
      bool = constant ? true : false
      @ole_obj.IsConstant = bool
    end

    def default
      @ole_obj.DefaultValue
    end

    def default=(val)
      @ole_obj.DefaultValue = val
    end

    def has_default?
      !!default
    end

    def hidden?
      @ole_obj.IsHidden
    end

    def hidden=(hidden)
      bool =  hidden ? true :false
      @ole_obj.IsHidden = bool
    end
    def prompt
      @ole_obj.Prompt
    end

    def prompt=(val)
      @ole_obj.Prompt = val
    end

    def type
      TYPES[@ole_obj.TagType]
    end

    def attrib_options
      options = {}
      options[:default] = default_value if has_default?
      options[:readonly] = true if constant?
      options
    end

    def ==(other)
      @ole_obj.Name == other.ole_obj.Name  && @ole_obj.TagSetName == other.ole_obj.TagSetName && @ole_obj.TagType == other.ole_obj.TagType
    end



  end



end
