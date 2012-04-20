require 'virtus'

module Microstation

  module Attribute


    class Base < Virtus::Attribute::Object

      accept_options :is_hidden, :prompt, :readonly


    end

    class String < Base

      primitive ::String

    end

    class Integer < Base
    end

    class Float < Base
    end

  end

end






