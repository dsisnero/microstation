require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'pry'


describe Microstation::Drawing do


  context "a drawing created with app.new_drawing" do

    before(:all) do
      @app = Microstation::App.new
      config_app(@app)
    end

    after(:all) do
      @app.close_active_drawing if @app
      @app.quit if @app
    end

    let(:name){ 'temp.dgn' }
    let(:path){ non_existent_path(name)}
    let(:new_drawing) { @app.new_drawing(path,'seed2d')}

    before(:each) do
      @app.close_active_drawing
      File.delete(path) if File.exist? path
    end

    it "should be the active drawing" do
      expect(new_drawing).to be_active
    end

    it "should have an ole_obj" do
      expect(new_drawing.ole_obj).to be_an_instance_of(WIN32OLE)
    end



    describe "#author" do

      it "should be "" for new drawing" do
        skip
        expect(new_drawing.author).to eq("")
      end

      it "should set author if given a new author" do
        new_drawing.author = "A newer author"
        expect(new_drawing.author).to eq "A newer author"
      end

    end

    describe "#title" do
      it "should be '' to start" do
        expect(new_drawing.title).to eq('')
      end

      it "should set title if given a new title" do
        new_drawing.title = "a new title"
        expect(new_drawing.title).to eq "a new title"
      end

    end

    describe "#keywords" do
      it "should be empty string to start" do
        expect(new_drawing.keywords).to eq("")
      end

      it "should set keywords if given a string of words" do
        new_drawing.keywords = "project, rcl, new"
        expect(new_drawing.keywords).to eq "project, rcl, new"
      end
    end

    describe "#comments" do

      it "should be nil to start" do
        expect(new_drawing.comments).to eq("")
      end

      it "should be able to be set" do
        new_drawing.comments = "these are comments"
        expect(new_drawing.comments).to eq "these are comments"
      end
    end



    it "should have a two_d? method" do
      expect(new_drawing).to be_two_d
    end

    it "should be able to save as pdf" do
      new_drawing.save_as_pdf
    end

    describe "revision count" do
      it "should have a revision_count" do
        expect(new_drawing).to respond_to(:revision_count)
      end

      it "should forward method" do
        expect(new_drawing.ole_obj).to receive(:DesignRevisionCount)
        new_drawing.revision_count
      end
    end

    describe "pdf_name" do

      context "with no args" do
        it "should equal the drawing path with ext changed" do
          expect(new_drawing).to receive(:name).and_return("Drawing Name.dgn")
          expect(new_drawing.pdf_name().to_s).to eq("Drawing Name.pdf")
        end
      end

      context "with 1 arg for name" do
        it "should equal the arg and the current directory" do
          expect(new_drawing.pdf_name('my_drawing').to_s).to eq("my_drawing.pdf")
        end
      end
    end



    context "save_as_pdf" do
      it "should find the pdf name with pdf_name rules" do
        skip
        path = new_drawing.path
        expect(new_drawing).to receive(:pdf_name).with( "testfile", nil)
        new_drawing.save_as_pdf("testfile")
      end
    end

    describe "scanning" do

      it "should have a #create_scanner" do
        scanner = new_drawing.create_scanner(:test)
        expect(scanner).to be_an_instance_of(Microstation::Scan::Criteria)
      end

      it "should scan the drawing" do
        scanner = new_drawing.create_scanner(:test) do |scan|
          expect(scan).to be_an_instance_of(Microstation::Scan::Criteria)
        end
        new_drawing.scan(scanner)
      end
    end

    describe "#scan_text" do

      it "only yields textual items" do
        new_drawing.scan_text do |item|
          expect(item.class).to eq((Microstation::Text) || Microstation::TextNode)
        end
      end
    end

    describe "#get_text" do
      let(:file_name){ 'drawing_with_block.dgn'}
      let(:drawing_file){ drawing_path(file_name)}
      let(:drawing_no_text_file){ drawing_path( 'drawing_no_block.dgn')}
      let(:drawing_no_text){ app.open_drawing(drawing_no_text_file)}
      let(:drawing_with_block){ app.open_drawing(drawing_file)}
      let(:app){ @app}

      it 'returns empty array if text has no text' do
        expect( drawing_no_text.get_text).to eq([])
      end

      it 'gets all the text if drawing has text' do
        text_in_drawing = text_for_drawing_with_block()
        text_from_drawing = drawing_with_block.get_text
        expect(text_from_drawing.sort ).to eq( text_for_drawing_with_block().sort )
      end


    end
  end
end


# describe "#name and path" do




#   context "when given a relative name and no project_dir" do
#     before(:each) do
#       @app.project_dir = nil
#       @drawing_name = "my drawing.dgn"
#       @path = @app.normalize_name(@drawing_name)

#     end

#     after(:each) do
#       @path.unlink
#     end

#     subject{@app.drawing(@drawing_name) }


#     it "#name should be set to the name of the drawing with .dgn extension" do
#       subject.name.should =~ "my drawing.dgn"
#     end

#     it "#path should be the working path" do
#       subject.path.should == Pathname.getwd
#     end

#   end

#   context "when given a relative name and a project_dir" do

#     before(:each) do
#       @app.project_dir = "c:/my_projects/"
#       @drawing = @app.drawing('my drawing')
#     end

#     after(:each) do
#       File.delete(@drawing.full_path)
#     end


#     it "name should be the name of the drawing" do
#       @drawing.name.should == 'my drawing.dng'
#     end

#     it "path should == the project_dir" do
#       drawing.path.should == "c:\\my_projects"
#     end

#   end
# end

# describe "#drawing" do
#   before(:each) do
#     ENV["USERNAME"] = "test person"
#   end

#   after(:each) do
#     @drawing.close
#     @drawing =  nil
#   end

#   it "should set author" do
#     @app.should_receive(:username).and_return("test person")
#     @drawing = @app.drawing(drawing_path)
#     @drawing.author.should == "test person"
#   end

# end

# describe "creating  a new drawing" do
#   before(:each) do
#     @drawing = @app.drawing(drawing_path)
#   end

#   after(:each) do
#     @drawing.close
#     @drawing = nil
#   end
