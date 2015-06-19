require File.join(File.dirname(__FILE__) ,  'spec_helper')

describe "Microstation::App" do

  before(:all) do
    @app = Microstation::App.new
    config_app(@app)
    @existing_drawing_path = drawing_path('test.dgn')
    @new_drawing_path = drawing_path('my_new_drawing.dgn')
  end

  before(:each) do
    File.delete(@new_drawing_path) if File.exist?(@new_drawing_path)
  end

  after(:all) do
    @app.close_active_drawing if @app
    @app.quit if @app
    File.delete(@new_drawing_path) if File.exist?(@new_drawing_path)
  end

  let(:app){@app}

  describe "#initialize" do

    context "visibility" do

      it "with no options visible is true" do
        test_app = Microstation::App.new
        expect(test_app).to_not be_visible
      end

      it "setting visible false" do
        test_app = Microstation::App.new(:visible => false)
        expect(test_app).not_to be_visible
      end

    end

  end

  describe "#can_open?" do


    it "can open a dwg file" do
      expect(app.can_open?('test.dwg')).to be true
    end

    it "can open a dgn file" do
      expect(app.can_open?('test.dgn')).to be true
    end

    it "can't open any other type of files" do
      %w(xls doc txt png tiff odf).each do |format|
        expect(app.can_open?("test.#{format}")).to be false
      end
    end
  end

  describe "#open_drawing" do

    let (:valid_file){ @existing_drawing_path }
    let (:invalid_file) {"bogus file"}

    it "returns a drawing if drawing exists" do
      drawing = app.open_drawing(valid_file)
      expect(drawing).to be_an_instance_of(Microstation::Drawing)
    end

    it "raises error if drawing does not exist" do
      expect {
        app.open_drawing(invalid_file)
      }.to raise_error
    end

    describe "when given a block" do

      it "yields the drawing to a block if a block is given" do
        app.open_drawing(valid_file) do |drawing|
          expect(drawing).to be_an_instance_of(Microstation::Drawing)
        end
      end


      it "closes drawing after block returns" do
        expect(app.active_design_file).to be_nil
        app.open_drawing(valid_file) do |drawing|
          expect(drawing).to be_an_instance_of(Microstation::Drawing)
        end
        expect(app.active_design_file).to be_nil
      end

    end

  end

  it "has an ole_object" do
    expect(app.ole_obj).to be_an_instance_of(WIN32OLE)
  end

  describe "load constants" do
    it "should load the constants" do
      app.load_constants
      expect(Microstation::MSD::MsdElementTypeTag).to eq(37)
    end
  end

  describe "create_scanner" do
    it "should yield a scanner object" do
      app.create_scanner(:test) do |scan|
        expect(scan).to be_an_instance_of(Microstation::Scan::Criteria)
        scan.include_tags
        scan.include_color(3)
      end

    end
  end


  describe "#normalize_name(name)" do

    it "returns the name if the name is absolute" do
      expect(app.normalize_name("c:/my_drawings/cool.dng").to_s).to eq("c:/my_drawings/cool.dgn")
    end

    context "when given a relative path and project dir is set" do
      it "returns the name joined with the project_dir" do
        app.project_dir = "c:/projects/new"
        expect(app.normalize_name('cool_beans.dng').to_s).to eq("c:/projects/new/cool_beans.dgn")
      end

    end

    context "when project_dir is nil" do
      it "returns name relative to the calling process" do
        app.project_dir = nil
        expected = Pathname.getwd + 'cool_beans.dgn'
        expect(app.normalize_name('cool_beans.dng').to_s).to eq(expected.to_s)
      end
    end
  end

  it "#windows path  method" do
    pending
    expect(app.windows_path( drawing_path(""))).to eq( "c:\\test")
  end


  it "should have a #username" do
    expect(app.username).to eq( ENV["USERNAME"])
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
      expect(drawing).to be_an_instance_of Microstation::Drawing
    end

    describe "when given a block" do

      it "yields the drawing to a block if a block is given" do
        app.new_drawing(new_drawing) do |drawing|
          expect(drawing).to be_an_instance_of( Microstation::Drawing)
        end
      end


      it "closes drawing after block returns" do
        expect(app.active_design_file).to be_nil
        app.new_drawing(new_drawing) do |drawing|
          expect(drawing).to be_an_instance_of( Microstation::Drawing)
        end
        expect(app.active_design_file).to be_nil
      end

    end

  end



  describe 'render_template' do
    # pending
    let(:dwg_with_block){ 'drawing_with_block.dgn'}
    let(:drawing_file){ drawing_path(dwg_with_block)}
    let(:output_dir){ output_path()}
    let(:output_file){ output_path( 'drawing_with_block.dgn')}

    it "doesn't error with a good template" do
      #   pending
      expect{ app.render_template(drawing_file,output_dir: output_dir, locals: {})}.to_not raise_error
    end

  end


  describe "an app with an open drawing" do
    before(:each) do
      #   File.delete(@new_drawing_path) if File.exist? (@new_drawing_path)
      #  @app.close_active_drawing
      # @drawing = @app.new_drawing(@new_drawing_path)
    end

    after(:each) do
      #  @app.close_active_drawing
      #
    end


    describe "#scan" do

      it "creates a scan criteria if not called with one" do
        drawing = app.new_drawing(@new_drawing_path)
        expect{app.scan}.to_not raise_error
        drawing.close
      end

    end

    #  it "resolves the scan criteria" do
    # drawing = app.new_drawing(@new_drawing_path)
    #   scanner = app.create_scanner(:t2) do |scan|
    #     scan.include_textual
    #   end
    #   app.scan(scanner)
    # drawing.close
    #  end



    describe "#current_drawing" do
      it 'returns the current drawing' do
        drawing = app.new_drawing(@new_drawing_path)
        d2 = app.current_drawing
        expect(d2.path.to_s.downcase).to eq( Pathname(@new_drawing_path).expand_path.to_s.downcase)

        drawing.close
      end
    end



  end

end
