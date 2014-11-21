require File.join(File.dirname(__FILE__) ,  'spec_helper')


describe Microstation::Configuration do

  before(:all) do
    @app = Microstation::App.new
    @configuration = Microstation::Configuration.new(@app)
    @defined_variable = "new_variable"
    @defined_value = "variable_value"
    @configuration[@defined_variable] = @defined_value
    @undefined_variable = 'undefined'
    @configuration.remove_variable @undefined_variable
  end

  after(:all) do
    @configuration.remove_variable(@undefined_variable)
    @app.quit
  end


  context "A configuration with defined and undefined variables" do
    let(:defined){ @defined_variable}
    let(:undefined){ @undefined_variable}
    subject(:config) { @configuration}

    describe "#exists" do

      it "should return true if config variable is exists" do
        expect(config.exists?(defined)).to be true
      end

      it "should return false if config variable doesn't exist" do
        expect( config.exists?(undefined)).to be false
      end

    end

    describe "#[]" do

      it "should check if value exists" do
        subject.should_receive(:exists?).with('undefined')
        expect(config[undefined]).to be_nil
      end

      it "should return the configuration variable if exists" do
        expect(config[defined]).to eq @defined_value
      end

      it "should return nil if not exists" do
        expect(config[undefined]).to equal nil
      end


    end

    describe "#should update" do

      it "should return true if key doesn't exist" do
        expect(config.should_update?(undefined)).to be true
      end

      it "should return false if key exists? and options[:force] not supplied" do
        expect(config.should_update?(defined)).to be false
      end

      it "should return true if key exists? and options[:force] is true" do
        expect(config.should_update?(defined, {:force => true})).to be true
      end

    end

    describe "setting variables" do

      context "value not existing yet" do

        it "should set the variable" do
          expect(config[undefined]).to eq nil
          config[undefined] = 'its set'
          expect(config[undefined]).to eq 'its set'
        end

      end

      context "value existing" do

        it "should raise variable defined if force option is false" do
          expect(config[defined]).to eq(@defined_value)
          expect{ config[defined] = "my new value"}.to raise_error  Microstation::VariableDefined
          expect(config[defined]).to eq(@defined_value)
        end

        it "should change the variable if force is true"  do
          expect(config[defined]).to eq( @defined_value)
          config.set!(defined,"my new value")
          expect( config[defined]).to eq 'my new value'
        end

      end

      describe "#expand" do
        it "should be able to expand string" do
          expect( config.expand( "$(_USTN_USER)")).not_to be nil
        end

      end

    end
  end

end
