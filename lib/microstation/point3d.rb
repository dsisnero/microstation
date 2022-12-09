module Microstation
  class Point3d
    class << self
      def ole_point3d?(ole)
        ole.instance_of?(WIN32OLE_RECORD) && ole.typename == 'Point3d'
      end

      def cartesian_to_polar(x, y)
        r = Math.sqrt(x * x + y * y)
        angle = Angle.radians(Math.atan2(y, x))
        [r, angle]
      end

      def from_polar_degrees(r, a); end

      def from_ole(ole)
        new(ole.X, ole.Y, ole.Z)
      end

      def polar_to_cartesian(r, a); end
    end

    attr_reader :x, :y, :z

    def initialize(x = 0, y = 0, z = 0)
      @x = x
      @y = y
      @z = z
    end

    def +(other)
      case other
      when Point3d
        self.class.new(x + other.x, y + other.y, z + other.z)
      when Array
        self.class.new(x + other[0], y + other[1])
      end
    end

    def -(other)
      case other
      when Point3d
        self.class.new(x - other.x, y - other.y, z - other.z)
      when Array
        self.class.new(x - other[0], y - other[1])
      end
    end

    def zero
      new(0.0, 0.0, 0, 0)
    end

    def to_cartesian; end
  end
end
