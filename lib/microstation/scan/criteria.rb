require_relative 'klass'
require_relative 'type'
require_relative 'level'
require_relative 'color'
require_relative 'line_style'
require_relative 'line_weight'
require_relative 'subtype'

module Microstation

  class App 

    def create_ole_scan_criteria
      ole_obj.CreateObjectInMicroStation("MicroStationDGN.ElementScanCriteria") 
    end
  end
  


  module Scan

    class Criteria

      include Scan::Klass
      include Scan::Type
      include Scan::Level
      include Scan::Color
      include Scan::LineStyle
      include Scan::LineWeight
      include Scan::Subtype
     
      attr_reader :app

      def self.create(app)
        sc = new(app)
        app.scanners << sc
        sc
      end
      

      def initialize(app)
        @app = app
        @ole_obj = @app.create_ole_scan_criteria
        @app.load_constants #unless defined? Microstation::MSD
   #     @app.scanners << self
      end
      
      def resolve
        resolve_type_scans
        resolve_class_scans
        resolve_color_scans
        resolve_level_scans
        resolve_linestyle_scans
        resolve_lineweight_scans
        resolve_subtype_scans
      end
      
      def close        
        @ole_obj = nil
        @app.scanners.delete(self) if @app
        @app = nil
      end    

      def ole_obj
        @ole_obj
      end      

    end
  end

end
