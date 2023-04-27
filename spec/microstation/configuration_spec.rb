# frozen_string_literal: true

require_relative "../spec_helper"

describe Microstation::Configuration do
  include Minitest::Hooks
  before(:all) do
    @app = Microstation::App.new
    config_app(@app)
  end

  after(:all) do
    @app.quit
  rescue
    nil
  end

  let(:config) { Microstation::Configuration.new(@app) }
  let(:defined_name) { "new_variable" }
  let(:defined_value) { "new_variable_value" }
  let(:undefined_name) { "undefined_variable" }

  before do
    config.remove_variable(undefined_name)
    config.set!(defined_name, defined_value)
  end

  describe "#remove_variable" do
    it "removes an existing variable" do
      _(config[defined_name]).must_equal defined_value
      config.remove_variable(defined_name)
      _(config[defined_name]).must_be_nil
    end

    it "doesn't error if variable nonexistent" do
      config.remove_variable "this_bogus_variable_should_not_exist"
    end
  end

  describe "#[]" do
    it "should check if value exists" do
      skip
      config_mock = Minitest::Mock.new
      config_mock.expect :exists?, true
      config.stub :[], config_mock do
        config["undefined"]
      end
      config_mock.verify
    end

    it "should return the configuration variable if exists" do
      _(config[defined_name]).must_equal defined_value
    end

    it "should return nil if not exists" do
      _(config[undefined_name]).must_be_nil
    end
  end

  describe "[]=, setting variables" do
    describe "value not existing yet" do
      it "should set the variable" do
        _(config[undefined_name]).must_be_nil
        config[undefined_name] = "its set"
        _(config[undefined_name]).must_equal "its set"
      end
    end

    describe "value existing" do
      it "should raise variable defined if force option is false" do
        _ { config[defined_name] = "my new value" }.must_raise ::Microstation::VariableDefined
      end

      it "should keep existing value" do
        _(config[defined_name]).must_equal defined_value
        _ { config[defined_name] = "my new value" }.must_raise
        _(config[defined_name]).must_equal defined_value
      end

      it "should change the variable if force is true" do
        _(config[defined_name]).must_equal(defined_value)
        config.set!(defined_name, "my new value")
        _(config[defined_name]).must_equal "my new value"
      end
    end
  end

  describe "#exists" do
    it "should return true if config variable exists" do
      _(config.exists?(defined_name)).must_equal true
    end

    it "should return false if config variable doesn't exist" do
      _(config.exists?(undefined_name)).wont_equal true
    end
  end

  describe "#prepend" do
    describe "variable exists" do
      it "should prepend the value" do
        value_before = config[defined_name]
        config.prepend(defined_name, "added")
        value_after = config[defined_name]
        _(value_after).must_equal "added;#{value_before}"
      end

      describe "variable nonexistent" do
        it "should add the value" do
          value_before = config[undefined_name]
          config.prepend(undefined_name, "added")
          value_after = config[undefined_name]
          _(value_after).must_equal "added"
        end
      end
    end
  end

  describe "#expand" do
    let(:dir) {}

    before do
      config["DIR"] = "c:/Users/Tom"
    end

    after do
      config.remove_variable("DIR")
    end

    it "should expand the string" do
      _(config.expand("$(DIR)/project")).must_equal "c:/Users/Tom/project"
    end
  end
end
