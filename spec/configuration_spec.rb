require File.join(File.dirname(__FILE__) ,  'spec_helper')


describe Microstation::Configuration do

  before(:all) do
    @app = Microstation::App.new
    @configuration = Microstation::Configuration.new(@app)
  end

  after(:all) do
    @app.quit
  end


  #  before(:each) do
  #   @defined_variable = "new_variable"
  #   @defined_value = "variable_value"
  #   @configuration[@defined_variable] = @defined_value
  #   @undefined_variable = 'undefined'
  #   @configuration.remove_variable @undefined_variable
  # end

  context "A configuration with defined and undefined variables" do

    let(:defined_name){ "new_variable" }
    let(:undefined_name){ "undefined_variable"}
    let(:defined_value){ "variable_value" }
    let(:defined) { @configuration[ defined_name]}
    let(:config){ @configuration}

    subject{ config}

    before(:each) do
      @configuration.remove_variable(undefined_name)
      @configuration.set!(defined_name,defined_value)
    end

    describe "#exists" do

      it "should return true if config variable is exists" do
        expect(config.exists?(defined_name)).to be true
      end

      it "should return false if config variable doesn't exist" do
        expect( config.exists?(undefined_name)).to be false
      end

    end

    describe "#prepend" do

      context 'variable exists' do

        it 'should prepend the value' do
          value_before = config[defined_name]
          config.prepend(defined_name, 'added')
          value_after = config[defined_name]
          expect( value_after).to eq('added' + ';' + value_before)
        end
      end

      context 'variable nonexistent' do

        it 'should add the value' do
          value_before = config[undefined_name]
          config.prepend(undefined_name, 'added')
          value_after = config[undefined_name]
          expect( value_after).to eq('added')
        end
      end
    end


    describe "#[]" do

      it "should check if value exists" do
        subject.should_receive(:exists?).with(undefined_name)
        expect(config[undefined_name]).to be_nil
      end

      it "should return the configuration variable if exists" do
        expect(config[defined_name]).to eq defined_value
      end

      it "should return nil if not exists" do
        expect(config[undefined_name]).to equal nil
      end


    end

    describe "#should update" do

      it "should return true if key doesn't exist" do
        expect(config.should_update?(undefined_name)).to be true
      end

      it "should return false if key exists? and options[:force] not supplied" do
        expect(config.should_update?(defined_name)).to be false
      end

      it "should return true if key exists? and options[:force] is true" do
        expect(config.should_update?(defined_name, {:force => true})).to be true
      end

    end

    describe "setting variables" do

      context "value not existing yet" do

        it "should set the variable" do
          expect(config[undefined_name]).to eq nil
          config[undefined_name] = 'its set'
          expect(config[undefined_name]).to eq 'its set'
        end

      end

      context "value existing" do

        it "should raise variable defined if force option is false" do
          expect(config[defined_name]).to eq(defined_value)
          expect{ config[defined_name] = "my new value"}.to raise_error  Microstation::VariableDefined
          expect(config[defined_name]).to eq(defined_value)
        end

        it "should change the variable if force is true"  do
          expect(config[defined_name]).to eq( defined_value)
          config.set!(defined_name,"my new value")
          expect( config[defined_name]).to eq 'my new value'
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
