require File.join(File.dirname(__FILE__) ,  'spec_helper')

module DrawingHelpers

  def create_new_drawing_path(name)
    path = drawing_path(name)
    File.delete(path) if File.exist? path
    return path
  end

end

describe Microstation::Drawing do
  include DrawingHelpers

  context "a drawing created with app.new_drawing" do
    
    before(:all) do
      @app = Microstation::App.new
      #     debugger
      @drawing_name = 'my_new_drawing.dgn'
      @new_drawing_path = create_new_drawing_path('my_new_drawing.dgn')
      @new_drawing = @app.new_drawing(@new_drawing_path)
    end
    
    after(:all) do
      @app.close_active_drawing if @app
      @app.quit if @app
      File.delete(@new_drawing_path) if File.exist?(@new_drawing_path || "")
    end

    let(:new_drawing) { @new_drawing}
    let(:new_drawing_path) { @new_drawing_path }
    let(:new_drawing_name) {@drawing_name}

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
        
    #     subject{@app.new_drawing(@drawing_name) }        
        

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
    #       @new_drawing = @app.new_drawing('my drawing')
    #     end

    #     after(:each) do
    #       File.delete(@new_drawing.full_path)
    #     end
        

    #     it "name should be the name of the drawing" do          
    #       @new_drawing.name.should == 'my drawing.dng'
    #     end

    #     it "path should == the project_dir" do
    #       drawing.path.should == "c:\\my_projects"
    #     end

    #   end
    # end
    
    it "should be the active drawing" do
      new_drawing.should be_active
    end

    describe "#author" do
     
      it "should be '' to start" do
         pending
        new_drawing.author.should == ""
      end

      it "should set author if given a new author" do
        new_drawing.author = "A newer author"
        new_drawing.author.should == "A newer author"
      end

    end

    describe "#title" do
      it "should be '' to start" do
        new_drawing.title.should == ""
      end

      it "should set title if given a new title" do
        new_drawing.title = "a new title"
        new_drawing.title.should == "a new title"
      end

    end

    describe "#keywords" do
      it "should be empty to start" do
        new_drawing.keywords.should == ""
      end

      it "should set keywords if given a string of words" do
        new_drawing.keywords = "project, rcl, new"
        new_drawing.keywords.should == "project, rcl, new"
      end
    end
    
    
    it "should have a #comments method" do
      new_drawing.comments.should == ""
      new_drawing.comments = "these are the comments"
      new_drawing.comments.should == "these are the comments"
    end

  


    it "should have a two_d? method" do
      new_drawing.should be_two_d
    end    

    it "should be able to save as pdf" do
      new_drawing.save_as_pdf
    end

    describe "revision count" do
      it "should have a revision_count" do
        new_drawing.should respond_to "revision_count"
      end

      it "should forward method" do
        new_drawing.ole_obj.should_receive("DesignRevisionCount").and_return(0)
        new_drawing.revision_count
      end
    end

    describe "pdf_name" do
      it "should be the name of the passed in arg if arg is passed in" do
        name = new_drawing.pdf_name("my_name")
        name.should =~ /my_name.pdf/
      end

      it "should == the name of the drawing file with pdf ext with no args" do
        new_drawing.stub(:name).and_return "Drawing Name"
        File.extname(new_drawing.pdf_name).should == '.pdf'
        File.basename(new_drawing.pdf_name, '.pdf').should == "Drawing Name"
      end

    end


    context "save_as_pdf" do
      it "should use the filename if given in args" do
        new_drawing.save_as_pdf("testfile")
      end
    end

    describe "scanning" do

    it "should have a #create_scanner" do
      scanner = new_drawing.create_scanner
      scanner.include_textual
      end

      it "should scan the drawing" do
        scanner = new_drawing.create_scanner do |scan|
          scan.include_textual
        end
        new_drawing.scan(scanner)
      end
    end
    

    

  end
end






    # describe "#new_drawing" do
    #   before(:each) do
    #     ENV["USERNAME"] = "test person"
    #   end

    #   after(:each) do
    #     @drawing.close
    #     @drawing =  nil
    #   end

    #   it "should set author" do
    #     @app.should_receive(:username).and_return("test person")
    #     @drawing = @app.new_drawing(new_drawing_path)
    #     @drawing.author.should == "test person"
    #   end

    # end      

    # describe "creating  a new drawing" do
    #   before(:each) do
    #     @drawing = @app.new_drawing(new_drawing_path)
    #   end

    #   after(:each) do
    #     @drawing.close
    #     @drawing = nil
    #   end






