module Microstation

  def self.needs_extending?(ole)
    ole.class == WIN32OLE && (not ole.respond_to? :text?)
  end

  class TaggedElement

    class Set

      attr_reader :element

      def initialize(name,element)
        @name = name
        @element = element
      end

      def name
        @name
      end

      def elements=(elements)
        elements.each do |ele|
          ele.base_element = @element
        end
        @elements = elements
      end

      def find_attribute(name)
        @elements.find{|a| a.name == name.to_s}
      end

      def [](name)
        find_attribute(name)
      end

      def attributes
        @elements.map{|e| e.name}
      end

      def update_element(name,value)
        find_attribute(name)._update(value)
      end

      def element_value(name)
        find_attribute(name).value
      end

      def to_hash
        result = {}
        @elements.each do |ele|
          result[ele.name] = ele.value unless (ele.value == "" || ele.value.nil?)
        end
        result
      end

      def stringify_keys(hash)
        result = {}
        hash.each do |key,value|
          result[key.to_s] = value
        end
        result
      end

      def update(value_hash)
        value_hash = stringify_keys(value_hash)
        valid_atts = attributes & value_hash.keys
        valid_atts.each do |att|
          update_element(att,value_hash[att])
        end
      end

      def method_missing(meth,*args,&block)
       # binding.pry
        base = meth.to_s.sub("=", "")
        if attributes.include?(base)
          if meth.match /(=)/
            update_element(base,*args)
          else
            element_value(base.to_s)
          end
        else
          super(meth,*args,&block)
        end
      end

    end

    def initialize(ole=nil)
      @ole_obj = ole
      @tag_sets = []
    end

    def add_tagset(name,elements)
      ts = TaggedElement::Set.new(name,self)
      ts.elements = elements
      @tag_sets << ts
      ts
    end

    def get_tagset(name)
      @tagsets.find{|ts| ts.name == name}
    end


  end

  class Element


    def self.convert_item(item)
      return item unless item.class == WIN32OLE
      case item.Type
      when Microstation::MSD::MsdElementTypeText
        Microstation::Text.new(item)
      when Microstation::MSD::MsdElementTypeTextNode
        Microstation::TextNode.new(item)
      when Microstation::MSD::MsdElementTypeTag
        Microstation::Tag.new(item)
      else
        new(item)
      end
    end

    def self.ole_object?
      ole.class == WIN32OLE
    end


    attr_reader :ole_obj

    def initialize(ole)
      @ole_obj = ole
      @original = ole_value
    end

    def update_ole(value)
    end

    def ole_value
    end

    def text?
      ole_obj.Type == Microstation::MSD::MsdElementTypeText
    end

    def text_node?
      ole_obj.Type  == Microstation::MSD::MsdElementTypeTextNode
    end

    def has_tags?
      ole_obj.HasAnyTags
    end

    def textual?
      text? || text_node?
    end

    def microstation_id
      ole_obj.Id || ole_obj.ID64
    end

    def Type
      ole_obj.Type
    end

    def microstation_type
      Type
    end

    def method_missing(meth,*args,&block)
      if meth.to_s =~ /^[A-Z]/
        result = ole_obj.send(meth,*args,&block)
        Element.convert_item(result)
      else
        super(meth,*args,&block)
      end
    end

    def _update(value)
      oldvalue = @original
      return if value == oldvalue
      begin
        update_ole(value)
        @ole_obj.Redraw Microstation::MSD::MsdDrawingModeNormal
        @ole_obj.Rewrite
        @original = value
      rescue
        _update(oldvalue)
      end
    end

  end
end

module Microstation

  module Wrap


    def wrap(item)
      Element.convert_item(item)
    end

    # def text?(item)
    #   item.Type == Microstation::MSD::MsdElementTypeText
    # end

    #  def text_node?(item)
    #   item.Type == Microstation::MSD::MsdElementTypeTextNode
    # end

  end
end
