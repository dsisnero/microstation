module Microstation

  module Scan

    module Range

      def include_within_range(range)
        ole_obj.IncludeOnlyWithinRange(range)
      end

      def range_from_points(pt1,pt2)
        app.Range3dFromPoint3dPoint3d(pt1,pt2)
      end

    end
  end


end
