module Microstation

  module Scan

    module Klass

      # msdElementClassPrimary # 0 (&H0)  
      # msdElementClassPatternComponent #1 (&H1)  
      # msdElementClassConstruction #2 (&H2)  
      # msdElementClassDimension #3 (&H3)  
      # msdElementClassPrimaryRule #4 (&H4)  
      # msdElementClassLinearPatterned #5 (&H5)  
      # msdElementClassContructionRule #6 (&H6)

      def class_inclusions
        @class_inclusions ||= []
      end

      def reset_classes
        reset_ole_classes
        @class_inclusions = []
      end

      def reset_ole_classes
        ole_obj.ExcludeAllClasses
      end      

      def include_class(klass)
        class_inclusions << klass
      end

      def resolve_class_scans
        return unless class_inclusions.size > 0
        reset_ole_classes
        class_inclusions.each do |klass|
          ole_obj.IncludeClass(klass)
        end
      end
      
    end
  end

end
