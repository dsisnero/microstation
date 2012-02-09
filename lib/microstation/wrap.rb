module Microstation

  module Wrap


     def wrap(item)
      return Microstation::Text.new(item) if text?(item)
      return Microstation::TextNode.new(item) if text_node?(item)
      item
    end    

    def text?(item)
      item.Type == Microstation::MSD::MsdElementTypeText
    end

    def text_node?(item)
      item.Type == Microstation::MSD::MsdElementTypeTextNode
    end       

  end
end
