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
      "#{name}: #{value}"
    end

    def value
      @original
    end

    def tagset
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


    def base_element
      @base_element ||= TaggedElement.new(ole_base_element)
    end

    # def _update(value)
    #   oldvalue = @original
    #   return if value == oldvalue
    #   begin
    #     update_ole(value)
    #     @ole_obj.Redraw Microstation::MSD::MsdDrawingModeNormal
    #     @ole_obj.Rewrite
    #     @original = value
    #   rescue
    #     _update(oldvalue)
    #   end
    # end

  end

end

