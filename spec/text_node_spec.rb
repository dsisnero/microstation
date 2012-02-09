require File.join(File.dirname(__FILE__) ,  'spec_helper')

module NodeHelper

  def text_node_scanner(app)
    app.create_scanner do |scan|
      scan.include_text_nodes
    end
  end
end




describe "Microstation::TextNode" do

  include NodeHelper

  context "given a TextNode" do

    before(:all) do
      @app = Microstation::App.new
      @scanner = text_node_scanner(app)
    end
    after(:all) do
      @app.quit
    end
    

    let(:app){ @app }
    let(:drawing) { open_existing_drawing(app) }
    let(:text_node) { drawing.scan(@scanner).find{|t|  !(t.empty?)  }}

    it "should forward Capitalized methods to @ole_obj" do
      ole = double('ole')
      text_node.stub(:ole_obj).and_return(ole)
      ole.should_receive('Type').and_return
      text_node.Type      
    end

    describe "ruby string methods" do

      context "calling with methods that don't change the string" do

        it "should not call the update method" do
          ole = double('ole')
          text_node.stub(:ole_obj).and_return(ole)
          text_node.should_not_receive('update_ole')
          ole.should_not_receive("Rewrite")
          text_node.reverse
          text_node.downcase
        end

        it "should give the correct value" do
          value = text_node.to_s
          text_node.reverse.to_s.should == value.reverse
        end

        it "should retain the same value" do
          value = text_node.to_s
          text_node.reverse
          text_node.to_s.should == value
        end
      end

      context "calling with methods that change the string" do

        it "should call the update method" do
          value = text_node.to_s
          reversed = value.reverse
          text_node.should_receive('update_ole').with(reversed)
          text_node.reverse!
        end

        it "should change to value" do
          value = text_node.to_s
          reversed = value.reverse
          text_node.reverse!
          text_node.to_s.should == reversed
        end

      end

    end

  end
end

        
        
        

