module Microstation
  def self.needs_extending?(ole)
    ole.instance_of?(WIN32OLE) && (!ole.respond_to? :text?)
  end

  module Microstation
    module Wrap
      def self.wrap(item, app, cell = nil)
        Element.convert_item(item, app, cell)
      end

      # def text?(item)
      #   item.Type == Microstation::MSD::MsdElementTypeText
      # end

      #  def text_node?(item)
      #   item.Type == Microstation::MSD::MsdElementTypeTextNode
      # end
    end
  end
end
