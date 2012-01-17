require_relative 'spec_helper'


describe Microstation::Drawing do
  
  before do
    @app = Microstation::App.new
    @drawing_path = drawing_path('new_drawing.dgn')
    File.delete(@drawing_path) if File.file?(@drawing_path)
  end

  after(:all) do
    @app.quit if @app
  end

  describe "on new_drawing" do
    before(:each) do
      ENV["USERNAME"] = "test person"
    end
    
    after(:each) do
      @drawing.close
      @drawing =  nil
    end
    
    it "should set author" do
      @app.should_receive(:username).and_return("test person")
      @drawing = @app.new_drawing(@drawing_path)
      @drawing.author.should == "test person"
    end

  end      

  describe "creating  a new drawing" do
    before(:each) do
      @drawing = @app.new_drawing(@drawing_path)
    end

    after(:each) do
      @drawing.close
      @drawing = nil
    end
    
    subject{ @drawing }
    
    it { should be_active }    

    it "should have a #title" do
      subject.title.should == ""
      subject.title = "this is the title"
      subject.title.should == "this is the title"
    end

    it "should have a #author method" do     
      subject.author = "Dominic Sisneros"
      subject.author.should == "Dominic Sisneros"
    end
    

    it "should have a #keywords method" do
      subject.keywords.should == ""
      subject.keywords = "project,rcl,test"
      subject.keywords.should == "project,rcl,test"
    end

    it "should have a #comments method" do
      subject.comments.should == ""
      subject.comments = "these are the comments"
      subject.comments.should == "these are the comments"
    end

    it "should have a name" do
      subject.name.should == "test"
    end

    it "should have a path" do
      subject.path.should == "dir"
    end
    

    it "should have a two_d? method" do
      subject.should be_two_d
    end    

    it "should be able to save as pdf" do
      subject.save_as_pdf
    end

    describe "revision count" do
      it "should have a revision_count" do
        subject.should respond_to "revision_count"
      end

      it "should forward method" do
        subject.ole_obj.should_receive("DesignRevisionCount").and_return(0)
        subject.revision_count
      end
    end

    describe "pdf_name" do
      it "should be the name of the passed in arg if arg is passed in" do
        name = subject.pdf_name("my_name")
        name.should =~ /my_name.pdf/
      end

      it "should == the name of the drawing file with pdf ext with no args" do
        name = subject.pdf_name()
        name.should == File.basename(@drawing_path)
      end

    end
    

    context "save_as_pdf" do
      it "should use the filename if given in args" do
        subject.save_as_pdf("testfile")
      end
    end
    
      

    it "should have a #create_scanner"
    

    
    

  end

end


