module Microstation

  class Text < Element

    def initialize(ole)
      @ole_obj = ole
      @original_text = @ole_obj.Text
    end

    # def microstation_id
    #   @ole_obj.Id || @ole_obj.ID64
    # end
    # def text?
    #   true
    # end

    # def text_node?
    #   false
    # end

    def to_s
      @original_text.to_s
    end

    def method_missing2(meth,*args, &block)
      if meth =~ /^[A-Z]/
        @ole_obj.send(meth,*args)
      else
        dup = @original_text.dup
        result = dup.send(meth,*args, &block)
        _update(dup) unless dup == @original_text
        result
      end
    end

    def method_missing(meth,*args,&block)
      dup = @original_text.dup
        result = dup.send(meth,*args, &block)
        _update(dup) unless dup == @original_text
      result
    end


    def _update(text)
      @ole_obj.Text = text
      @original_text = text
      @ole_obj.Redraw Microstation::MSD::MsdDrawingModeNormal
      @ole_obj.Rewrite
      @original_text = text
    end

  end

end
