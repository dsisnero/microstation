module Microstation

  module Scan

    module Level

      def level_inclusions
        @level_inclusions ||= []
      end

      def include_level(level)
        level_inclusions << level
      end
      
      def reset_levels
        reset_ole_levels
        @level_inclusions = []
      end

      def reset_ole_levels
        ole_obj.ExcludeAllLevels
      end

      def resolve_level_scans
        return unless level_inclusions.size > 0
        reset_ole_levels
        level_inclusions.each do |level|
          ole_obj.IncludeLevel(level)
        end
      end

    end

  end

end

      
