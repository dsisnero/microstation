require_relative 'wrap'

module Microstation

  class Enumerator

    include Enumerable

    def initialize(ole)
      @ole_obj = ole
    end

    def each
      while @ole_obj.MoveNext
        item = @ole_obj.Current
        yield Microstation::Wrap.wrap(item)
      end
    end

    def reset
      @ole_obj.reset
    end



  end

end
