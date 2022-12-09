module Microstation
  class TaggedElement
    class Set
      attr_reader :element, :name

      def initialize(name, element)
        @name = name
        @element = element
      end

      def elements=(elements)
        elements.each do |ele|
          ele.base_element = @element
        end
        @elements = elements
      end

      def find_attribute(name)
        @elements.find { |a| a.name == name.to_s }
      end

      def [](name)
        find_attribute(name)
      end

      def attributes
        @elements.map { |e| e.name }
      end

      def update_element(name, value)
        find_attribute(name)._update(value)
      end

      def element_value(name)
        find_attribute(name).value
      end

      def to_hash
        result = {}
        @elements.each do |ele|
          result[ele.name] = ele.value unless ele.value == '' || ele.value.nil?
        end
        result
      end

      def stringify_keys(hash)
        result = {}
        hash.each do |key, value|
          result[key.to_s] = value
        end
        result
      end

      def update(value_hash)
        value_hash = stringify_keys(value_hash)
        valid_atts = attributes & value_hash.keys
        valid_atts.each do |att|
          update_element(att, value_hash[att])
        end
      end

      def method_missing(meth, *args, &block)
        # binding.pry
        base = meth.to_s.sub('=', '')
        if attributes.include?(base)
          if meth.match(/(=)/)
            update_element(base, *args)
          else
            element_value(base.to_s)
          end
        else
          super(meth, *args, &block)
        end
      end
    end

    def initialize(ole = nil)
      @ole_obj = ole
      @tag_sets = []
    end

    def add_tagset(name, elements)
      ts = TaggedElement::Set.new(name, self)
      ts.elements = elements
      @tag_sets << ts
      ts
    end

    def get_tagset(name)
      @tagsets.find { |ts| ts.name == name }
    end
  end
end
