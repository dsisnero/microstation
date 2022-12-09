module Microstation
  module Scan
    module Type
      # MsdElementTypeCellLibraryHeader
      # MsdElementTypeCellHeader
      # MsdElementTypeLine
      # MsdElementTypeLineString
      # MsdElementTypeGroupData
      # MsdElementTypeShape
      # MsdElementTypeTextNode
      # MsdElementTypeDigSetData
      # MsdElementTypeDesignFileHeader
      # MsdElementTypeLevelSymbology
      # MsdElementTypeCurve
      # MsdElementTypeComplexString
      # MsdElementTypeConic
      # MsdElementTypeComplexShape
      # MsdElementTypeEllipse
      # MsdElementTypeArc
      # MsdElementTypeText
      # MsdElementTypeSurface
      # MsdElementTypeSolid
      # MsdElementTypeBsplinePole
      # MsdElementTypePointString
      # MsdElementTypeCone
      # MsdElementTypeBsplineSurface
      # MsdElementTypeBsplineBoundary
      # MsdElementTypeBsplineKnot
      # MsdElementTypeBsplineCurve
      # MsdElementTypeBsplineWeight
      # MsdElementTypeDimension
      # MsdElementTypeSharedCellDefinition
      # MsdElementTypeSharedCell
      # MsdElementTypeMultiLine
      # MsdElementTypeTag
      # MsdElementTypeDgnStoreComponent
      # MsdElementTypeDgnStoreHeader
      # MsdElementType44
      # MsdElementTypeMicroStation
      # MsdElementTypeRasterHeader
      # MsdElementTypeRasterComponent
      # MsdElementTypeRasterReference
      # MsdElementTypeRasterReferenceComponent
      # MsdElementTypeRasterFrame
      # MsdElementTypeTableEntry
      # MsdElementTypeTable
      # MsdElementTypeViewGroup
      # MsdElementTypeView
      # MsdElementTypeLevelMask
      # MsdElementTypeReferenceAttachment
      # MsdElementTypeMatrixHeader
      # MsdElementTypeMatrixIntegerData
      # MsdElementTypeMatrixDoubleData
      # MsdElementTypeMeshHeader
      # MsdElementTypeReferenceOverride
      # MsdElementTypeNamedGroupHeader
      # MsdElementTypeNamedGroupComponent

      def type_inclusions
        @type_inclusions ||= []
      end

      def reset_types
        reset_ole_types
        @type_inclusions = []
      end

      def reset_ole_types
        ole_obj.ExcludeAllTypes
      end

      def include_type(type)
        type_inclusions << type
      end

      def resolve_type_scans
        return unless type_inclusions.size > 0

        reset_ole_types
        type_inclusions.each do |type|
          ole_obj.IncludeType(type)
        end
      end

      def include_cell_header
        include_type(::Microstation::MSD::MsdElementTypeCellHeader)
      end

      def include_shared_cell
        include_type(::Microstation::MSD::MsdElementTypeSharedCell)
      end

      def include_cells
        include_cell_header
        include_shared_cell
      end

      def include_dimensions
        include_type(::Microstation::MSD::MsdElementTypeDimension)
      end

      def include_text
        include_type(::Microstation::MSD::MsdElementTypeText)
      end

      def include_tags
        include_type ::Microstation::MSD::MsdElementTypeTag
      end

      def include_text_nodes
        include_type ::Microstation::MSD::MsdElementTypeTextNode
      end

      def include_textual
        include_text
        include_text_nodes
      end

      def include_solids
        include_type ::Microstation::MSD::MsdElementTypeSolid
      end

      def include_lines
        include_type ::Microstation::MSD::MsdElementTypeLine
      end
    end
  end
end
