module Microstation
  module Scan
    module Subtype
      def subtype_inclusions
        @subtype_inclusions ||= []
      end

      def include_subtype(subtype)
        subtype_inclusions << subtype
      end

      def reset_subtypes
        reset_ole_subtypes
        @subtype_inclusions = []
      end

      def reset_ole_subtypes
        ole_obj.ExcludeAllSubtypes
      end

      def resolve_subtype_scans
        return unless subtype_inclusions.size > 0
        reset_ole_subtypes
        subtype_inclusions.each do |subtype|
          ole_obj.IncludeSubtype(subtype)
        end
      end
    end
  end
end
