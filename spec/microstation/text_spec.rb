# frozen_string_literal: true

require_relative "../spec_helper"

describe "Microstation:Text and Microstation::TextNode" do
  include Minitest::Hooks
  before(:all) do
    @app = Microstation::App.new
    config_app(@app)
  end
  after(:all) do
    @app.quit
  rescue
    nil
  end

  describe "given a text node initialized by a scan" do
    let(:drawing) { open_existing_drawing("drawing_with_text.dgn") }
    let(:criteria) { @app.create_scanner(&:include_textual) }

    before do
      text_array = drawing.scan_model(criteria).to_a
      @text = text_array.find { |t| t.instance_of?(Microstation::Text) }
    end

    let(:text) { @text }

    it "should be an instance of text" do
      _(text).must_be_instance_of Microstation::Text
    end

    it "should forward all the Microstation commands to ole_obj" do
      _(text.IsTextElement).must_equal true
    end

    it "should update the drawing if the text is changed" do
      id = text.microstation_id
      val = text.to_s
      text.reverse!
      drawing_text = drawing.find_by_id(id)
      _(drawing_text.to_s).must_equal(val.reverse)
    end
  end
end
