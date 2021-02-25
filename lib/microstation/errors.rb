module Microstation

  Error = Class.new(::RuntimeError)
  NonDGNFile = Class.new(Error)
  FileNotFound = Class.new(Error)
  MultipleUpdateError = Class.new(Error)
  class ExistingFile < Error

    def initialize(path)
      msg = "File at path #{path} already exists"
      super(msg)
    end
  end



end
