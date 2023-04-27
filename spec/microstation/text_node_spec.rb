# frozen_string_literal: true

require_relative "../spec_helper"

describe "Microstation::TextNode" do
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

  describe "given a TextNode" do
    let(:app) { @app }
    let(:scanner) { app.create_scanner(:text, &:include_text_nodes) }
    let(:drawing) { open_existing_drawing("drawing_with_text.dgn") }
    let(:text_node) { drawing.scan_model(scanner).find { |t| !t.empty? } }

    it "should forward Capitalized methods to @ole_obj" do
      ole = Minitest::Mock.new
      ole.expect(:Type, "A ole type")
      text_node.stub(:ole_obj, ole) do
        _(text_node.Type).must_equal "A ole type"
      end
      ole.verify
    end

    describe "ruby string methods" do
      describe "calling with methods that don't change the string" do
        it "should not call the update method" do
          skip
          ole = Minitest::Mock.new
          mock.expect(:update, true)
          text_node.stub(:upcase, true)

          ole = Minitest::Mock.new
          text_node.reverse
          text_node.downcase
        end

        it "should give the correct value" do
          value = text_node.to_s
          _(text_node.reverse.to_s).must_equal(value.reverse)
        end

        it "should retain the same value" do
          value = text_node.to_s
          result = text_node.reverse
          _(text_node.to_s).must_equal(value)
          _(text_node.to_s).wont_equal result
        end
      end

      describe "calling with methods that change the string" do
        it "should change the value" do
          value = text_node.to_s
          result = text_node.reverse!
          _(text_node.to_s).must_equal(result)
          _(text_node.to_s).wont_equal(value)
        end
      end
    end
  end
end
