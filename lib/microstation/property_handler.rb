module Microstation

  class PropertyHandler

    attr_reader :ole_obj

    def initialize(ole)
      @ole_obj = ole
    end

    def has_property?(value)
      prop = ole_obj.SelectByAccessString(value)
      !!(prop)
    end

    def [](property)
      return unless has_property?(property)
      ole_obj.GetValue
    end

    def get_property_as_point3d(property)
      return unless has_property?(property)
      ole_pt = ole_obj.GetValueAsPoint3d
      Point3d.new(ole_pt)
    end


    def []=(property,value)
      return unless has_property?(property)
      ole_obj.SetValue(value)
    end

    def property_names
      names = ole_obj.GetAccessStrings
      result  = []
      names.each do |e|
        if block_given?
          yield e
        else
          result << e
        end
      end
      result unless block_given?
    end

  end

end
