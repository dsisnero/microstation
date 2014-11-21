module Microstation

  class VariableDefined < ::StandardError
    end

  class Configuration

    def initialize(app)
      @app = app
    end

    def [](variable)
      return nil unless exists? variable
     value(variable)
    end

    def should_update?(key,options={force: false})
      return true unless exists? key
      force = options.fetch(:force){ false}
      return !!force
    end

    def remove_variable(variable)
      workspace.RemoveConfigurationVariable variable
    end

    def set(key,value,options = {})
      raise Microstation::VariableDefined unless should_update?(key,options)
      set!(key,value)
    end

    def set!(key,value)
      workspace.AddConfigurationVariable(key,value)
    end


    def []=(key,value)
      set(key,value)
     end

    def value(variable)
      workspace.ConfigurationVariableValue(variable)
    end

    def exists?(value)
      workspace.IsConfigurationVariableDefined(value)
    end

    def expand(string)
      workspace.ExpandConfigurationVariable(string)
    end

    private
    def workspace
      @app.active_workspace
    end


  end

end
