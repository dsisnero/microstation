module Microstation
  module Graphics
    def line(p1, p2, el = WIN32OLE_VARIANT::Nothing)
      pt1 = app.to_ole_point3d(p1)
      pt2 = app.to_ole_point3d(p2)
      begin
        ole = app.ole_obj.CreateLineElement2(el, pt1, pt2)
      rescue Exception => e
        binding.break
        return nil
      end
      add_element(ole) if ole
    end

    def line_from_pts(pts, el = WIN32OLE_VARIANT::Nothing)
      ole_points = pts.map { |pt| app.to_ole_point3d(pt) }
      ole = app.ole_obj.CreateLineElement1(el, ole_points)
      if ole
        add_element(ole)
      else
        binding.break
      end
    rescue Exception => e
      binding.break
      nil
    end
  end
end
