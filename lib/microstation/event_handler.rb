module Microstation

  class EventHandler
    def initialize
      @handlers = {}
    end

    def add_handler(event, &block)
      if block_given?
        @handlers[event] = block
      end
    end

    def get_handler(event)
      @handlers[event]
    end

    def method_missing(event, *args)
      if @handlers[event.to_s]
        @handlers[event.to_s].call(*args)
      else
        puts "Unhandled event: #{event} args: #{args}"
        super
      end
    end
  end

end
