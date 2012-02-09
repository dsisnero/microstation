require File.join(File.dirname(__FILE__) ,  'spec_helper')

describe "Microstation:Text and Microstation::TextNode" do


  context "given a text node initialized by a scan" do

    before(:all) do
      @app = Microstation::App.new
      @drawing = open_existing_drawing(@app)
      @criteria = @app.create_scanner do |scan|
        scan.include_textual        
      end
      @text_scan = @drawing.scan(@criteria)
      @text_enum = @text_scan.to_enum
      @text = @text_enum.find{|t| t.class == Microstation::Text}
    end

    after(:all) do
      @app.quit
    end

    let(:app) { @app}
    let(:drawing) {@drawing}
    let(:text) { @text}

    it "should be an instance of text" do
      text.should be_instance_of Microstation::Text
    end

    it "should forward all the methods to underlying text" do
      val = text.to_s
      text.reverse.should == val.reverse
      text.to_s.should == val
      puts "text: #{text}"
    end

    it "should forward all the Microstation commands to ole_obj" do
      pending
      text.IsTextElement.should be_true
    end

    it "should update the drawing if the text is changed" do
      pending
      id = text.microstation_id
      debugger
      puts "id: #{id}"
      puts "id class #{id.class}"
      val = text.to_s
      text.reverse!
      drawing_text = app.find_by_id(id)
      drawing_text.to_s.should == val.reverse      
    end
    
    
    

  end

end


