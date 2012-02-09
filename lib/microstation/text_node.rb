module Microstation

  class TextNode

    attr_reader :original_text, :ole_obj

    def initialize(ole)
      @ole_obj = ole
      @original_text = ole_to_ruby(ole)
    end

    def empty?
      ole_obj.TextLinesCount == 0
    end
    
    def text?
      false
    end

    def size
      ole_obj.TextLinesCount
    end
    

    def ole_to_ruby(ole)
      count = ole.TextLinesCount
      #    debugger if count > 0
      str_array = []
      1.upto(count) do |i|
        str_array << ole.TextLine(i)
      end
      str_array.join("\n")
    end
    
    def text_node?
      true
    end

    def _update(text)
      update_ole(text)
      @original_text = text
    end

    def update_ole(text)
      ole_obj.DeleteAllTextLines
      text.each_line do |line|
        ole_obj.AddTextLine(line)
      end
      ole_obj.Redraw Microstation::MSD::MsdDrawingModeNormal
      ole_obj.Rewrite
    end

    def to_s
      @original_text.to_s
    end
    
    def method_missing(meth,*args,&block)
      if meth.to_s =~ /^[A-Z]/
        ole_obj.send(meth,*args)
      else
        dup = @original_text.dup
        result = dup.send(meth,*args,&block)
        _update(dup) unless dup == @original_text
        result
      end
    end      

  end

end
