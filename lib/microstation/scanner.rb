module Microstation


  class Scanner

    attr_reader :app

    def initialize(app)
      @app = app
      @ole_obj = @app.create_ole_scanner
    end

    private

    def ole_obj
      @ole_obj
    end
    
    

  end


end
