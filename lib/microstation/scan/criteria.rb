require_relative 'klass'
require_relative 'type'
require_relative 'level'
require_relative 'color'
require_relative 'line_style'
require_relative 'line_weight'
require_relative 'subtype'
require_relative 'range'

module Microstation

  class App

    def create_ole_scan_criteria
      ole_obj.CreateObjectInMicroStation("MicroStationDGN.ElementScanCriteria")
    end

  end

end

module Microstation

  module Scan

    class Criteria

      include Scan::Klass
      include Scan::Type
      include Scan::Level
      include Scan::Color
      include Scan::LineStyle
      include Scan::LineWeight
      include Scan::Subtype
      include Scan::Range

      attr_reader :app

      def self.create_scanner(name=nil, app,&block)
        sc = create(name,app)
        return sc unless block
        block.arity < 1 ? sc.instance_eval(&block) : block.call(sc)
        sc
      end

      def self.create(name=nil,app)
        sc = new(app)
        if name.nil?
          name = "anon#{app.scanners.size + 1}"
        end
        app.scanners[name] = sc
        sc
      end


      def initialize(app)
        @app = app
        @ole_obj = @app.create_ole_scan_criteria
        @app.load_constants unless defined? ::Microstation::MSD
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
        @app.scanners.delete(self) if @app
        @ole_obj = nil
      end

      def ole_obj
        @ole_obj
      end

      def method_missing(method,*args)
        @ole_obj.send(method,*args)
      end


    end
  end

end
