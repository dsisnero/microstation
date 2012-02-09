require File.join(File.dirname(__FILE__) ,  'spec_helper')


describe Microstation::Configuration do

  before(:all) do
    @app = Microstation::App.new
    @configuration = Microstation::Configuration.new(@app)
  end

  after(:all) do
    @app.quit
  end
  

  subject { @configuration}

  describe "#exists" do
    it "should return true if config variable is exists" do
      subject.exists?("MS_DEF").should be_true
    end

    it "should return false if config variable is unexists" do
      subject.exists?("NO_VALUE").should be_false
    end

  end  

  describe "#[]" do

    it "should check if value exists" do
      variable = "test"
      subject.should_receive(:exists?).with("test").and_return(false)
      subject["test"]
    end

    
    it "should return the configuration variable if exists" do
      @configuration["MS_DEF"].should_not == nil
    end

    it "should return nil if not exists" do
      @configuration["NO_VALUE_IN_[]"].should == nil
    end
    

  end

  describe "#should update" do

    it "should return true if key doesn't exist" do
      @configuration.should_update?("NO_EXISTING_KEY",{}).should be_true
    end

    it "should return false if key exists? and options[:force] is false or nil" do
      @configuration.should_update?("MS_DEF",{}).should be_false
    end

    it "should return true if key exists? and options[:force] is true" do
      @configuration.should_update?("MS_DEF", {:force => true}).should be_true
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
      before(:each) do
        @configuration[@variable] = "a new variable"
      end      
      
      it "should raise variable defined if force option is false" do
        @configuration[@variable].should == "a new variable"
        expect{ @configuration["MS_DEF"]= "my new value"}.to raise_error  Microstation::VariableDefined
        @configuration[@variable].should == "a new variable"
      end

      it "should change the variable if force is true"  do
        @configuration[@variable].should == "a new variable"
        @configuration.set(@variable, "my new value", :force => true)
        @configuration[@variable].should == "my new value"
      end


    end
    

    describe "#expand" do
      it "should be able to expand string" do
        @configuration.expand( "$(_USTN_USER)$(_USTN_USERNAME).txt").should_not be_nil
        
      end

    end
    
    

  end



end
