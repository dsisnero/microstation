module Microstation

  module Scan

    module Color

      def color_inclusions
        @color_inclusions ||= []
      end

      def include_color(color)
        color_inclusions << color
      end

      def reset_colors
        reset_ole_colors
        @color_inclusions = []
      end

      def reset_ole_colors
        ole_obj.ExcludeAllColors
      end

      def resolve_color_scans
        return unless color_inclusions.size > 0
        reset_ole_colors
        color_inclusions.each do |color|
          ole_obj.IncludeColor(color)
        end
      end

    end

  end
end

      
      
