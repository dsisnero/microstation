require File.join(File.dirname(__FILE__) ,  'spec_helper')



describe "Microstation::TextNode" do

  before(:all) do
    @app = Microstation::App.new
  end

  after(:all) do
    @app.quit if @app
    @app = nil  end

  context "given a TextNode" do

    let(:app){ @app }
    let(:scanner){ app.create_scanner(:text){|scan| scan.include_text_nodes }}
    let(:drawing) { open_existing_drawing(app) }
    let(:text_node) { drawing.scan(scanner).find{|t|  !(t.empty?)  }}

    it "should forward Capitalized methods to @ole_obj" do
      ole = double('ole')
      expect(text_node).to receive(:ole_obj){ ole}
      expect(ole).to receive(:Type)
      text_node.Type
    end

    describe "ruby string methods" do

      context "calling with methods that don't change the string" do

        it "should not call the update method" do
          expect(text_node).not_to receive(:ole_obj){ ole}
          expect(text_node).not_to receive(:update_ole!)
          text_node.reverse
          text_node.downcase
        end

        it "should give the correct value" do
          value = text_node.to_s
          expect(text_node.reverse.to_s).to eq(value.reverse)
        end

        it "should retain the same value" do
          value = text_node.to_s
          text_node.reverse
          expect(text_node.to_s).to eq(value)
        end
      end

      context "calling with methods that change the string" do

        it "should call the update method" do
          value = text_node.to_s
          reversed = value.reverse
          expect(text_node).to receive(:update_ole!).with(reversed)
          text_node.reverse!
        end

        it "should change to value" do
          value = text_node.to_s
          lines_count = value.lines.size
          reversed = value.reverse
          ole = double('ole')
          expect(text_node).to receive(:ole_obj).at_least(:once).and_return(ole)
          expect(ole).to receive(:DeleteAllTextLines)
          expect(ole).to receive(:AddTextLine).exactly(lines_count).times
          expect(ole).to receive(:Redraw)
          expect(ole).to receive(:Rewrite)
          text_node.reverse!
          expect(text_node.to_s).to eq(reversed)
        end

      end

    end

  end
end
