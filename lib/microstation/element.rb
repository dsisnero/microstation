module Microstation


  module ElementTrait

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
      id = ole_obj.Id || ole_obj.ID64
      if id.class == WIN32OLE_RECORD
        if id.Low > id.High
          return id.Low
        else
          return id.High
        end
      end
      id
    end

    def Type
      ole_obj.Type
    end

    def microstation_type
      Type
    end

  end

  class Element

    include ElementTrait

    def self.convert_item(ole)
      return ole unless ole.class == WIN32OLE
      case ole.Type
      when Microstation::MSD::MsdElementTypeText
        Microstation::Text.new(ole)
      when Microstation::MSD::MsdElementTypeTextNode
        Microstation::TextNode.new(ole)
      when Microstation::MSD::MsdElementTypeTag
        Microstation::Tag.new(ole)
      else
        new(ole)
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
