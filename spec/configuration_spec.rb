require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'pry'

describe Microstation::Configuration do

  before(:all) do
    @app = Microstation::App.new
    @configuration = Microstation::Configuration.new(@app)
    @defined_variable = "new_variable"
    @defined_variable_value = "variable_value"
    @configuration[@defined_variable] = @defined_variable_value
    @undefined_variable = 'undefined'
    @configuration.remove_variable('undefined')
  end

  after(:all) do
    @configuration.remove_variable(@defined_variable)
    @app.quit
  end


  describe "#exists" do
    let(:variable){ @defined_variable}
    let(:undefined){ @undefined_variable}
    subject { @configuration}

    it "should return true if config variable is exists" do
      subject.exists?(variable).should be_true
    end

    it "should return false if config variable doesn't exist" do
      subject.exists?(undefined).should be_false
    end

  end

  describe "#[]" do
    let(:undefined){ @undefined_variable}
    let(:variable){ @defined_variable}
    subject{@configuration}

    it "should check if value exists" do
      subject.should_receive(:exists?).with('undefined')
      expect(subject[undefined]).to be_nil
    end

    it "should return the configuration variable if exists" do
      expect(subject[variable]).to eq 'variable_value'
    end

    it "should return nil if not exists" do
      expect(@configuration[undefined]).to equal nil
    end


  end

  describe "#should update" do

    let(:undefined){@undefined}
    let(:variable){@defined_variable}

    it "should return true if key doesn't exist" do
      @configuration.should_update?(undefined).should be_true
    end

    it "should return false if key exists? and options[:force] is false or nil" do
      @configuration.should_update?(variable).should be_false
    end

    it "should return true if key exists? and options[:force] is true" do
      @configuration.should_update?(variable, {:force => true}).should be_true
    end

  end

  describe "setting variables" do

    before(:each) do
      @variable = "TEST_VARIABLE"
      @configuration.remove_variable(@variable)
    end

    context "value not existing yet" do

      it "should set the variable" do
        @configuration[@variable].should == nil
        @configuration[@variable] = "a new variable"
        @configuration[@variable].should == "a new variable"
      end

    end

    context "value existing" do

      let(:variable){@defined_variable}
      subject{ @configuration}

      it "should raise variable defined if force option is false" do
        @configuration[variable].should == 'variable_value'
        expect{ @configuration[variable]= "my new value"}.to raise_error  Microstation::VariableDefined
        @configuration[variable].should == "variable_value"
      end

      it "should change the variable if force is true"  do
        @configuration[variable].should == "variable_value"
        @configuration.set(variable, "my new value", :force => true)
        @configuration[variable].should == "my new value"
      end

    end

    describe "#expand" do
      it "should be able to expand string" do
        @configuration.expand( "$(_USTN_USER)$(_USTN_USERNAME).txt").should_not be_nil

      end

    end

  end
end
