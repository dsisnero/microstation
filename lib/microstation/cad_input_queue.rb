module Microstation

  
  class CadInputQueue

    def initialize(ole_obj)
      @ole_obj = ole_obj
    end

    def <<(string)
      send_keyin(string)
    end

    def send_keyin(string)
      @ole_obj.SendKeyin(string)
    end

    def close
      @ole_ojb = nil
    end


  end

end
