module Microstation

  module CriteriaCreationT

    def text_criteria
      app.scanners[:textual] || app.create_scanner(:textual){ include_textual}
    end

    def graphic_criteria
      app.scanners[:graphical] || app.create_scanner(:graphical){ ExcludeNonGraphical}
    end

    def tags_criteria
      app.scanners[:tags] || app.create_scanner(:tags){ include_tags}
    end

    def cells_criteria
      app.scanners[:cells] || app.create_scanner(:cells){ include_cells}
    end

  end

end
