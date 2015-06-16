module Microstation

  class Point3d

    attr_reader :ole_obj

     def initialize(ole,app=nil)
      @ole_obj = ole
      @app = app
    end

    def x
      @ole_obj.X
    end

    def y
      @ole_obj.Y
    end

    def z
      @ole_obj.Z
    end

    def +(other)
      pt2 = @app.to_point(other)
      @app.Point3d(x + pt2.x, y + pt2.y, z + pt2.z)
    end


  end


end
