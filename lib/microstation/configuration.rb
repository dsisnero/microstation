module Microstation

  class VariableDefined < ::StandardError
    end


  class App

    def with_config

    end

  end



  class Configuration

    def initialize(app)
      @app = app
    end

    def prepend(variable,value)
      if exists?(variable)
        old_value = get(variable)
        new_value = "#{value};#{old_value}"
      else
        new_value = value.to_s
      end
      set!(variable,new_value)
    end

    def append(variable,value)
      if exists?(variable)
        old_value = get(variable)
        new_value = "#{old_value};#{value}"
      else
        new_value = value.to_s
      end
      set!(variable,new_value)
    end

    def [](variable)
      return nil unless exists? variable
     get(variable)
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
      self.remove_variable(key)
      workspace.AddConfigurationVariable(key,value)
    end


    def []=(key,value)
      set(key,value)
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

  def get(variable)
      workspace.ConfigurationVariableValue(variable)
    end


  end

end
