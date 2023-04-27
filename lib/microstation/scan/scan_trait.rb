module Microstation
  module ScanTrait
    def create_scanner(&block)
      app.create_scanner(&block)
    end

    def scan_graphical(&block)
      sc = create_scanner
      sc.ExcludeNonGraphical
      scan(sc, &block)
    end

    def scan_text(&block)
      sc = create_scanner do
        include_textual
      end
      scan(sc, &block)
    end

    def scan(criteria, &block)
      scan_result = ole_run_scan(criteria)
      return [] unless scan_result

      scan_enum = Microstation::Enumerator.new(scan_result)
      result = []
      if block
        scan_enum.each(&block)
      else
        scan_enum.each do |item|
          result << item
        end
      end

      return result unless block
    end

    private

    def ole_run_scan(criteria)
      criteria.resolve
      scan_result = begin
        ole_obj.Scan(criteria.ole_obj)
      rescue
        nil
      end
    end
  end
end
