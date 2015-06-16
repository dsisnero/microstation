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

    def send_command(text)
      @ole_obj.SendCommand(text)
    end

    def method_missing(name,*args,&block)
      @ole_obj.send(name,*args,&block)
    end



  end

end
