module PrimitiveCommandInterface
  def Keyin(keyin)
  end

  def DataPoint(pt, view)
  end

  def Reset
  end

  def Cleanup
  end

  def Dynamics(pt, view, drawmode)
  end

  def Start
  end
end

class LineCreation
  include PrimitiveCommandInterface

  attr_reader :points

  def initialize(app)
    @app = app
    @points = Array.new(2)
  end

  def DataPoint(pt, _view)
    case points.compact.size
    when 0
      app.ole_obj.CommandState.StartDynamics
      @points[0] = pt
      app.show_prompt "Place end point"
    when 1
      @points[1] = pt
      line_from_pts(@points)
      @points[0] = @points[1]
    end
  end

  def Dynamics(pt, _view, _drawmode)
    return unless @points.compact.size == 1

    @points[1] = pt
    line = line_from_pts(@points)
  end

  def Reset
    app.CommandState.StartPrimitive self
    @points = Array.new(2)
  end

  def Start
    app.show_command "VBA PlaceLine Example"
    app.show_prompt "Select start of line"
  end
end
