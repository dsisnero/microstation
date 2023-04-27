require "microstation/element"

module Microstation
  class Text < Element
    def read_ole(_ole)
      ole_obj.Text
    end

    def write_ole(text)
      ole_obj.Text = text
    end

    def to_regexp
      Regexp.new(read_ole.to_s)
    end

    def =~(reg)
      @original =~ reg
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
      original.to_s
    end

    def bounds
      binding.pry
      rotation = ole_obj.Rotation
      inverse_rotation = begin
        app_ole_obj.Matrix3dInverse(rotation)
      rescue
        pry
      end
      transform = app_ole_obj.Transform3dFromMatrix3dandFixedPoint3d(app_ole_obj.Matrix3dInverse(rotation),
        ole_obj.origin)
      ole_obj.transform transform
      pts = []

      0.upto(4) do |i|
        points[i] = ole_obj.Boundary.Low
      end
      points[2] = self.Boundary.High
      points[1].X = points[2].x
      points[3].y = points[2].Y
    end

    def method_missing(meth, *args, &block)
      if /^[A-Z]/.match?(meth)
        ole_obj.send(meth, *args)
      else
        dup = @original.dup
        result = dup.send(meth, *args, &block)
        update(result)
        result
      end
    end

    # def method_missing(meth,*args,&block)
    #   dup = @original_text.dup
    #     result = dup.send(meth,*args, &block)
    #     _update(dup) unless dup == @original_text
    #   result
    # end
  end
end
