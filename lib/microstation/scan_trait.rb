require_relative 'criteria_creation_t'
module Microstation

  module ScanTrait

     def create_scanner(name,&block)
      app.create_scanner(name, &block)
    end

    def text_criteria
      app.scanners[:textual] || app.create_scanner(:textual){ include_textual}
    end

    def graphics_criteria
      app.scanners[:graphical] || app.create_scanner(:graphical){ ExcludeNonGraphical}
    end

    def tags_criteria
      app.scanners[:tags] || app.create_scanner(:tags){ include_tags}
    end

    def cells_criteria
      app.scanners[:cells] || app.create_scanner(:cells){ include_cells}
    end

    def lines_criteria
      app.scanners[:lines] || app.create_scanner(:lines){ include_lines}
    end

    def scan_graphical(&block)
      self.scan_model(graphic_criteria, &block)
    end

    def scan_text(&block)
      self.scan_model(text_criteria,&block)
    end

    def scan_tags(&block)
      self.scan_model(tags_criteria,&block)
    end

    def scan_cells(&block)
      self.scan_model(cells_criteria,&block)
    end

    def scan_lines(&block)
      self.scan_model(lines_criteria, &block)
    end


    def scan_cell_with_name(name, &block)
      sc = create_scanner
      sc.IncludeOnlyCell(name)
      sc.include_cell
      self.scan_model(sc,&block)
    end



  end

end
