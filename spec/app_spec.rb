require_relative 'spec_helper'


describe Microstation::App do

  describe "when initialized" do
    before do
      @app = Microstation::App.new
    end

    after(:all) do
      @app.quit
    end

    it "has an ole_object" do
      @app.ole_obj.class.should == ::WIN32OLE
    end

    it "can_open a .dwg drawing" do
      @app.can_open?("test.dgn").should be_true
    end

    it "can_open a dgn drawing" do
      @app.can_open?("test.dwg").should be_true
    end

    it "can't open any other types" do
      %w( xls doc txt png tiff ).each do |format|
        @app.can_open?("test.#{format}").should be_false
        end
    end

    it "#windows path  method" do
      @app.windows_path( drawing_path("")).should == "c:\\test"
    end


    it "should have a #username" do
      @app.username.should == ENV["USERNAME"]
    end
    


    describe "#opening drawings" do
      before(:each) do
        @app.close_active_drawing
        @valid_drawing = drawing_path('pih-d-atct-q650.dgn')
      end

      describe "when drawing exists" do

        it "returns a Drawing" do
          @app.active_design_file.should == nil
          drawing = @app.open_drawing(@valid_drawing)
          drawing.class.should == Microstation::Drawing
          @app.active_design_file.should.eql? drawing.ole_obj
          
        end

        it "yield a block if block given" do
          @app.active_design_file.should == nil
          @app.open_drawing(@valid_drawing) do |drawing|
            drawing.class.should == Microstation::Drawing
            @app.active_design_file.should.eql? drawing.ole_obj
          end
        end

        it "closes drawing after block returns" do
          @app.active_design_file.should == nil
          @app.open_drawing(@valid_drawing) do |drawing|
            @app.active_design_file.should.eql? drawing.ole_obj
          end
          @app.active_design_file.should == nil
        end        

      end

      describe "when drawing doesn't exist" do

        it "should error" do
          
          expect {
            @app.open_drawing('non_drawing')
          }.to raise_error
        end
      end
    end

    describe "#new_drawing" do

      before(:each) do
        @app.close_active_drawing
      end      

      it "needs a filename" do
        expect{ @app.new_drawing}.to raise_error
      end

      it "creates a new drawing if given a name" do
        drawing = @app.new_drawing("test.dgn")
        drawing.should be_an_instance_of Microstation::Drawing
      end

      # it "saves drawing" do
      #   drawing = @app.new_drawing("test.dgn")
      #   drawing.keywords = "projects,rcl"
      #   drawing.save
      # end
         
      
      it "takes optional seed file"
      it "returns drawing"

    end    


    # it "forwards method missing" do
      
    #   @app.ole_obj.should_receive("Open")
    #   @app.Open("this is a drawing")
      

    # end

    
  end




  describe "#run" do

    it "yields an instance of app" 
    
    it "closes automatically"
    it "closes excel application"
  end






end
