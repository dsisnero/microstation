module Microstation

  module TS

    class Attribute

      attr_reader :ole_obj

      # msdTagTypeCharacter 1 (&H1)
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
        if type.class == Symbol
          ruby_type = case type
                      when :char
                        String
                      when :int
                        Integer
                      when :float
                        Float
                      else
                        :char
                      end
        else
          ruby_type = type
        end

        RUBY_TO_MS[ruby_type]
      end

      def att_type
        TYPES[type]
      end

      def initialize(ole, options = {})
        @ole_obj = ole
        @definition = options[:definer]
      end

      def close
        @ole_obj = nil
      end

      def tagset
        @definition.tagset if definition
      end

      def name
        @ole_obj.name
      end

      def name=(val)
        @ole_obj.Name = val
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

      def tagset_name
        @ole_obj.TagSetName
      end

      def ==(other)
        @ole_obj.Name == other.ole_obj.Name  && @ole_obj.TagSetName == other.ole_obj.TagSetName && @ole_obj.TagType == other.ole_obj.TagType
      end

    end

  end
end
