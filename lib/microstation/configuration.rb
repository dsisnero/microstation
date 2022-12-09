module Microstation
  class Capabilities
    attr_reader :variable, :capabilities

    def initialize(config, variable)
      @config = config
      @variable = variable
      @capabilities = get_capabilities
    end

    def get_capabilities
      @capabilities = @config[variable].split(';')
    end

    def search(name)
      @capabilities.select { |c| c =~ Regexp.new(Regexp.escape(name), Regexp::IGNORECASE) }
    end

    def enabled
      @capabilities.select { |c| c.start_with?('+') }
    end

    def disabled
      @capabilities.select { |c| c.start_with?('-') }
    end

    def enabled?(name)
      capa = remove_prefix(name)
      @capabilities.any? { |c| c == "+#{capa}" }
    end

    def disabled?(name)
      capa = remove_prefix(name)
      @capabilities.any? { |c| c == "-#{capa}" }
    end

    def write_configuration
      caps = @capabilities.uniq.join(';')
      @config.set!(variable, caps)
    end

    def prepend(value)
      @config.prepend(variable, value)
    end

    def enable(name)
      return if enabled?(name) && !disabled?(name)

      capa = remove_prefix(name)
      @capabilities.delete("-#{capa}")
      @capabilities.unshift("+#{capa}")
      write_configuration
      get_capabilities
      self
    end

    def disable(name)
      return if disabled?(name) && !enabled?(name)

      capa = remove_prefix(name)
      capabilities.delete("+#{name}")
      @capabilities.unshift("-#{capa}")
      write_configuration
      get_capabilities
      self
    end

    def remove_prefix(name)
      name = Regexp.last_match(1) if name =~ /[+-](.+)/
      name
    end
  end

  class VariableDefined < ::StandardError
  end

  class App
    def with_config; end
  end

  class Configuration
    def initialize(app)
      @app = app
    end

    def prepend(variable, value)
      if exists?(variable)
        old_value = get(variable)
        new_value = "#{value};#{old_value}"
      else
        new_value = value.to_s
      end
      set!(variable, new_value)
    end

    def append(variable, value)
      if exists?(variable)
        old_value = get(variable)
        new_value = "#{old_value};#{value}"
      else
        new_value = value.to_s
      end
      set!(variable, new_value)
    end

    def [](variable)
      return nil unless exists? variable

      get(variable)
    end

    def remove_variable(variable)
      workspace.RemoveConfigurationVariable variable
    end

    def set(key, value, options = {})
      raise VariableDefined unless should_update?(key, options)

      set!(key, value)
    end

    def set!(key, value)
      remove_variable(key)
      workspace.AddConfigurationVariable(key, value)
    end

    def []=(key, value)
      set(key, value)
    end

    def exists?(value)
      workspace.IsConfigurationVariableDefined(value)
    end

    def capabilities_all
      @workmode_all ||= Capabilities.new(self, '_USTN_CAPABILITY')
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

    def should_update?(key, options = { force: false })
      return true unless exists? key

      force = options.fetch(:force) { false }
      !!force
    end
  end

  class App
    def capabilities(mode = :all)
      case mode
      when :all
        configuration.capabilities_all
      when :dwg
        configuration.capabilites_dwg
      when :v7
        configuration.capabilities_v7
      else
        configuration_capabilities_all
      end
    end
  end
end
