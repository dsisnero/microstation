require_relative 'tagged_element'



module Microstation

  class Tag < Element

    # def initialize(ole)
    #   @ole_obj = ole
    #   @original = @ole_obj.Value
    # end

    def read_ole(ole)
      ole.Value
    end

    def write_ole(value)
      value = value.nil? ? "" : value
      ole_obj.Value = value
    end


    def ole_value
      @ole_obj.Value
    end

    def name
      @ole_obj.TagDefinitionName
    end

    
    def inspect
      "#{name}: #{value} ts ->#{tagset_name}"
    end

    def to_s
      "#{value}"
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
      base = ole_base_element
      id = base.Id || base.ID64 rescue nil
      if id.class == WIN32OLE_RECORD
        if id.Low > id.High
          return id.Low
        else
          return id.High
        end
      end
      id
    end

    def base_element
      @base_element ||= TaggedElement.new(ole_base_element)
    end

  end



end
