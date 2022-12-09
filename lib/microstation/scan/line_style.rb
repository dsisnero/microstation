module Microstation
  module Scan
    module LineStyle
      def linestyles
        @app.active_design_file.LineStyles
      rescue StandardError
        []
      end

      def linestyle_inclusions
        @linestyle_inclusions ||= []
      end

      def include_linestyle(style)
        linestyle_inclusions << style
      end

      def reset_linestyles
        reset_ole_linestyles
        @linestyle_inclusions = []
      end

      def reset_ole_linestyles
        ole_obj.ExcludeAllLineStyles
      end

      def resolve_linestyle_scans
        return unless linestyle_inclusions.size > 0

        reset_ole_linestyles
        linestyle_inclusions.each do |linestyle|
          ole_obj.IncludeLineStyle(linestyle)
        end
      end
    end
  end
end
