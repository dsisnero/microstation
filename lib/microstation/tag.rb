module Microstation

  class Tag < Element

    def initialize(ole)
      @ole_obj = ole
      @original = @ole_obj.Value
    end

    def ole_value
      @ole_obj.Value
    end

    def name
      @ole_obj.TagDefinitionName
    end

    def to_s
      "#{name}: #{value} ts ->#{tagset_name}"
    end

    def value
      @original
    end

    def tagset
      @ole_obj.TagSetName
    end

    def tagset_name
      @ole_obj.TagSetName
    end

    def update_ole(value)
      value = value.nil? ? "" : value
      @ole_obj.Value = value
    end

    def base_element=(ele)
      @base_element = ele
    end

    def ole_base_element
      @ole_obj.BaseElement
    end

    def base_element_id
      ole_base_element.ID64
    end

    def base_element
      @base_element ||= TaggedElement.new(ole_base_element)
    end

  end

end

