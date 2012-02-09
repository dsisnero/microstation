require File.join(File.dirname(__FILE__) ,  'spec_helper')

describe "Microstation::Enumerator" do

  context "given a drawing scanned with a textual criteria" do

    before(:all) do
      @app = Microstation::App.new
      @drawing = open_existing_drawing(@app)
      @criteria = @app.create_scanner do |scan|
        scan.include_textual
      end
      
    end

    after(:all) do
      @app.close_active_drawing
      @app.quit
      # path = @drawing.full_path
      #path.delete
    end

    let(:app) { @app}
    let(:drawing){@drawing}

    describe "app.scan" do
      it "returns an Enumerator" do
        pending
        enum = app.scan(@criteria)
        enum.should be_an_instance_of Microstation::Enumerator
      end

      it "should be a text node" do
        enum = app.scan(@criteria).to_enum
        first = enum.next
        first.should be_an_instance_of Microstation::Text
      end

      it "should all be textual" do
        pending
        enum = app.scan(@criteria)
        values = enum.map{|i| i}
      end
      
      
    end

    

    

    

  end

end




