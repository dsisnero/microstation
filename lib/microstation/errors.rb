module Microstation

  Error = Class.new(::RuntimeError)
  NonDGNFile = Class.new(Error)
  FileNotFound = Class.new(Error)
  MultipleUpdateError = Class.new(Error)


end
