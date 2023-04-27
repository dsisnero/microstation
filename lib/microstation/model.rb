# require_relative 'scan/scan_trait'
require "microstation/wrap"
require_relative "model_trait"

# require_relative 'ts/tagset_trait'
# require_relative 'graphics'
# require_relative 'ts/instance'

module Microstation
  class DefaultModel
    include ::Microstation::ModelTrait

    attr_reader :app, :ole_obj

    def initialize(app, ole)
      @app = app
      @ole_obj = ole
    end

    def drawing
      @drawing ||= ::Microstation::Drawing.from_ole_obj(app, ole_obj)
    end
  end

  class Model
    include ::Microstation::ModelTrait

    attr_reader :app, :drawing, :ole_obj

    def initialize(app, drawing, ole)
      @app = app
      @drawing = drawing
      @ole_obj = ole
    end
  end
end
