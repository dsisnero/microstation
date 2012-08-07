require File.join(File.dirname(__FILE__) ,  'spec_helper')

describe "Microstation::App" do

  before(:all) do
    @app = Microstation::App.new
    @existing_drawing_path = drawing_path('test.dgn')
    @new_drawing_path = drawing_path('my_new_drawing.dgn')
  end

  before(:each) do
    File.delete(@new_drawing_path) if File.exist?(@new_drawing_path)
  end


  after(:all) do
    @app.quit if @app
    @app = nil
  end

  let(:app){@app}

  describe "#initialize" do
    it "with no options visible is true" do
      app = Microstation::App.new
      app.should be_visible
    end

    it "works with options" do
      app = Microstation::App.new(:visible => false)
      app.should_not be_visible
    end

  end

  describe "#can_open?" do


    it "can open a dwg file" do
      app.can_open?('test.dwg').should be_true
    end

    it "can open a dgn file" do
      app.can_open?('test.dgn').should be_true
    end

    it "can't open any other type of files" do
      %w(xls doc txt png tiff odf).each do |format|
        app.can_open?("test.#{format}").should be_false
      end
    end
  end

  describe "#open_drawing" do

    after(:each) do
      app.close_active_drawing
    end


    let (:valid_file){ @existing_drawing_path }
    let (:invalid_file) {"bogus file"}

    it "returns a drawing if drawing exists" do
      drawing = app.open_drawing(valid_file)
      drawing.class.should == Microstation::Drawing
      app.active_design_file.should.eql? drawing.ole_obj
    end

    it "raises error if drawing does not exist" do
      expect {
        app.open_drawing(invalid_file)
      }.to raise_error
    end

    describe "when given a block" do

      it "yields the drawing to a block if a block is given" do
        app.open_drawing(valid_file) do |drawing|
          drawing.class.should == Microstation::Drawing
          app.active_design_file.should.eql? drawing.ole_obj
        end
      end


      it "closes drawing after block returns" do
        app.active_design_file.should == nil
        app.open_drawing(valid_file) do |drawing|
          app.active_design_file.should.eql? drawing.ole_obj
        end
        app.active_design_file.should == nil
      end

    end

  end

  it "has an ole_object" do
    app.ole_obj.class.should == ::WIN32OLE
  end

  describe "load constants" do
    it "should load the constants" do
      app.load_constants
      Microstation::MSD::MsdElementTypeTag.should == 37
    end
  end

  describe "create_scanner" do
    it "should yield a scanner object" do
      app.create_scanner do |scan|
        scan.should be_instance_of Microstation::Scan::Criteria
        scan.include_tags
        scan.include_color(3)
      end

    end
  end




  describe "#create_ole_scanner" do
    it "returns an ole scanner" do
      pending
      scanner = app.create_ole_scan_criteria
      scanner.ole_type.to_s.should =~ /_ElementScanCriteria/
    end
  end

  describe "#normalize_name(name)" do

    it "returns the name if the name is absolute" do
      app.normalize_name("c:/my_drawings/cool.dng").to_s.should == "c:/my_drawings/cool.dgn"
    end

    context "when given a relative path and project dir is set" do
      it "returns the name joined with the project_dir" do
        app.project_dir = "c:/projects/new"
        app.normalize_name('cool_beans.dng').to_s.should == "c:/projects/new/cool_beans.dgn"
      end

    end

    context "when project_dir is nil" do
      it "returns name relative to the calling process" do
        app.project_dir = nil
        app.normalize_name('cool_beans.dng').to_s.should == (Pathname.getwd + 'cool_beans.dgn').to_s
      end
    end
  end

  it "#windows path  method" do
    pending
    app.windows_path( drawing_path("")).should == "c:\\test"
  end


  it "should have a #username" do
    app.username.should == ENV["USERNAME"]
  end

  describe "#new_drawing" do
    # before(:each) do
    #   @new_name = "my_new_drawing.dgn"
    #   @new_drawing_path = drawing_path(@new_name)
    #   @existing_drawing_path = drawing_path('test.dgn')
    # end

    after(:each) do
      app.close_active_drawing
     # File.delete(@new_drawing_path) if File.exist?(@new_drawing_path)
    end

    let(:existing_drawing){ @existing_drawing_path }
    let(:new_drawing) { @new_drawing_path }


    it "needs a filename" do
      expect{ app.new_drawing()}.to raise_error
    end

    it "raises an error if drawing exists" do
      expect {
        app.new_drawing(existing_drawing).to raise_error
      }
    end

    it "creates a drawing if it's a new drawing_name" do
      drawing = app.new_drawing(new_drawing)
      drawing.should be_an_instance_of Microstation::Drawing
    end

    describe "when given a block" do

      it "yields the drawing to a block if a block is given" do
        app.new_drawing(new_drawing) do |drawing|
          drawing.class.should == Microstation::Drawing
          app.active_design_file.should.eql? drawing.ole_obj
        end
      end


      it "closes drawing after block returns" do
        app.active_design_file.should == nil
        app.new_drawing(new_drawing) do |drawing|
          app.active_design_file.should.eql? drawing.ole_obj
        end
        app.active_design_file.should == nil
      end

    end

  end

  describe "an app with an open drawing" do
    before(:each) do
      @drawing = app.new_drawing(@new_drawing_path)
    end

    after(:each) do
      app.close_active_drawing
    #  File.delete(@new_drawing_path) if File.exist? (@new_drawing_path)
    end

    describe "#scan" do
      it "defaults to all objects without a scan criteria" do
        pending
        expect{app.scan}.to_not raise_error
      end

      it "resolves the scan criteria" do
        scanner = app.create_scanner do |scan|
          scan.include_textual
        end
        scanner.should_receive("resolve")
        app.scan(scanner)
      end



    end

    # describe "#current_drawing" do
    #   it "returns the current drawing" do
    #     binding.pry
    #     app.current_drawing.should == @drawing
    #   end

    # end




  end

  # it "forwards method missing" do

  #   @app.ole_obj.should_receive("Open")
  #   @app.Open("this is a drawing")


  # end


end

