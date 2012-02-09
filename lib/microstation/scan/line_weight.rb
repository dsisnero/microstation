module Microstation

  module Scan

    module LineWeight

      def lineweight_inclusions
        @lineweight_inclusions ||= []
      end

      def include_lineweight(weight)
        lineweight_inclusions << weight
      end

      def reset_lineweights
        reset_ole_linestyles
        @lineweight_inclusions = []
      end

      def reset_ole_lineweights
        ole_obj.ExcludeAllLineWeights
      end

      def resolve_lineweight_scans
        return unless lineweight_inclusions.size > 0
        reset_ole_lineweights
        lineweight_inclusions.each do |lineweight|
          ole_obj.IncludeLineWeight(lineweight)
        end
      end
    end
  end
end
