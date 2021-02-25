require_relative 'wrap'

module Microstation

  class Enumerator

    include Enumerable

    attr_reader :app

    def initialize(ole,app)
      @ole_obj = ole
      @app = app
    end

    def each
      return enum_for(:each) unless block_given?
      while @ole_obj.MoveNext
        item = @ole_obj.Current
        yield Microstation::Wrap.wrap(item,app)
      end
    end

    def reset
      @ole_obj.reset
    end



  end

end
