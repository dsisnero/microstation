require File.join(File.dirname(__FILE__) ,  'spec_helper')


describe Microstation::Scan::Criteria do

  before(:all) do
    @app = Microstation::App.new
  end

  after(:all) do
    @app.quit
  end

  let(:app) { @app}

  describe "#initialize" do

    before(:each) do
      @ole = double("scan_enum")
      app.stub(:create_ole_scan_criteria).and_return(@ole)
      app.stub(:load_constants)
    end    

    it "requires an app as argument" do
      expect {
        Microstation::Scan::Criteria.new()
      }.to raise_error
      
    end

    it "sets the ole_obj to the passed in ole_obj" do
      scanner = Microstation::Scan::Criteria.new(app)
      scanner.send(:app).should equal(app)
    end

    it "sets the ole_obj variable" do
      scanner = Microstation::Scan::Criteria.new(app)
      scanner.send(:ole_obj).should equal(@ole)
    end

  end
  

  describe "Microstation::Scan::Criteria" do
    before(:each) do
      @scanner = Microstation::Scan::Criteria.create(app)
    end

    after(:each) do
      @scanner.close
    end
    

    # after(:all) do
    #   @scanner = nil
    #   @app.quit
    # end

    let(:scanner){ @scanner}

    it "removes the object from the scanner array on close" do
      app.scanners.should have(1).item
      app.scanners.find{|s| s == scanner}.should == scanner
      scanner.close
      app.scanners.should_not include(scanner)
      scanner.ole_obj.should be_nil
      scanner.app.should be_nil
    end    

    it "can be reset level" do
      scanner.reset_levels
    end

    it "can reset types" do
      scanner.reset_types
    end

    it "can reset classes" do
      scanner.reset_classes
    end

    it "can reset all exclusions" do

      %w(classes colors levels linestyles lineweights subtypes types).each do |method|
        scanner.send("reset_#{method}")
      end
    end

    describe 'the win32ole object' do
      before(:each) do
        @ole = double('ole')
        @ole.stub('load_constants')
        scanner.stub('ole_obj').and_return @ole
      end

      after(:each) do
        @ole = nil
      end
      
      let(:ole){@ole}      

      it "can scan by type" do        
        ole.should_receive('ExcludeAllTypes')          
        ole.should_receive('IncludeType').with 37# Microstation::MSD::MsdElementTypeTag
        scanner.include_tags
        scanner.resolve        
      end

      it "can scan by color" do        
        ole.should_receive('ExcludeAllColors')
        ole.should_receive('IncludeColor').with(3)
        scanner.include_color(3)
        scanner.resolve        
      end

      it "can scan by linestyle" do        
        ole.should_receive('ExcludeAllLineStyles')
        ole.should_receive('IncludeLineStyle')
        scanner.include_linestyle( scanner.linestyles[0])
        scanner.resolve        
      end

      it "can scan by lineweight" do
        ole.should_receive('ExcludeAllLineWeights')
        ole.should_receive('IncludeLineWeight')
        scanner.include_lineweight(3)
        scanner.resolve
      end

      it "can scan by subtype" do
        ole.should_receive('ExcludeAllSubtypes')
        ole.should_receive('IncludeSubtype')
        scanner.include_subtype( Microstation::MSD::MsdElementSubtypeAuxiliaryCoordinateSystem)
        scanner.resolve
      end

      it "can scan by multiple" do
        ole.should_receive('ExcludeAllColors')
        ole.should_receive('IncludeColor').with(3)
        ole.should_receive('ExcludeAllTypes')
        ole.should_receive('IncludeType').with(37)
        scanner.include_color(3)
        scanner.include_tags
        scanner.resolve
      end
      
      
      
    end

  end

end


