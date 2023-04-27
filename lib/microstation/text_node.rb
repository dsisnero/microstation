module Microstation
  class TextNode < Element
    attr_reader :original, :ole_obj

    def to_regexp
      Regexp.new(original.to_s)
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

    def read_ole(ole)
      count = ole.TextLinesCount
      #    debugger if count > 0
      str_array = []
      1.upto(count) do |i|
        str_array << ole.TextLine(i)
      end
      str_array.join("\n")
    end

    # def _update(text)
    #   update_ole!(text)
    #   @original = text
    # end

    def write_ole(text)
      if in_cell?
        write_ole_in_cell(text)
      else
        write_ole_regular(text)
      end
    end

    def write_ole_regular(text)
      ole_obj.DeleteAllTextLines
      text.each_line do |line|
        ole_obj.AddTextLine(line)
      end
    end

    def write_ole_in_cell(text)
      orig_ole = ole_obj
      new_text_ole = ole_obj.Clone
      new_text_ole.DeleteAllTextLines
      text.each_line do |line|
        new_text_ole.AddTextLine(line)
      end
      @ole_obj = new_text_ole
    rescue => e
      @ole_obj = orig_ole
    end

    def update_ole!(text)
      ole_obj.DeleteAllTextLines
      text.each_line do |line|
        ole_obj.AddTextLine(line)
      end
      ole_obj.Redraw Microstation::MSD::MsdDrawingModeNormal
      ole_obj.Rewrite
    end

    def to_s
      @original.to_s
    end

    def =~(reg)
      @original =~ reg
    end

    def template?
      !!(@original =~ /{{.+}}/)
    end

    def render(h = {})
      return self unless template?

      template = Liquid::Template.parse(to_s)
      result = template.render(h)
      update(result) unless result == @original
      self
    end

    def method_missing(meth, *args, &block)
      if /^[A-Z]/.match?(meth)
        ole_obj.send(meth, *args)
      else
        copy = @original.dup
        result = copy.send(meth, *args, &block)
        update(result) unless copy == @original
        result
      end
    end

    # def method_missing2(meth,*args,&block)
    #   if meth.to_s =~ /^[A-Z]/
    #     ole_obj.send(meth,*args)
    #   else
    #     dup = @original.dup
    #     result = dup.send(meth,*args,&block)
    #     _update(dup) unless dup == @original
    #     result
    #   end
    # end
  end
end
