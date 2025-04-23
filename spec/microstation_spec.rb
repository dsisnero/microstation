# frozen_string_literal: true

require_relative "spec_helper"


describe Microstation do
  describe "#root" do
    subject { Microstation.root }

    it "to_s" do
      _(subject.to_s).must_equal(Pathname.getwd.to_s)
    end
  end

  describe "default error proc" do
    subject { Microstation }

    it "can change error proc" do
      _(Microstation.default_error_proc = ->(e, f) { "Hi there" })
      _(Microstation.open_drawing("nonexisrent")).must_equal("Hi there")
    end
  end

  describe "#run" do
    it "opens up and yields an app" do
      result = nil
      Microstation.run do |app|
        _(app).must_be_instance_of(Microstation::App)
      end
    end
  end

  describe "#get_text" do
    let(:drawing_with_text) { drawing_path("drawing_with_text.dgn") }
    let(:drawing_no_text) { drawing_path("drawing_no_block.dgn") }
    let(:text_for_drawing_with_text) {
      [
        "Four score and seven years ago our fathers brought forth",
        "Out out brief candle\nLifes but a walking shadow",
        "It is my lady, it is my love\nOh that she knew she were"
      ]
    }

    describe "when drawing has text" do
      it "returns the text" do
        text = Microstation.get_text(drawing_with_text)
        _(text.sort).must_equal(text_for_drawing_with_text.sort)
      end
    end

    describe "when drawing has no text" do
      it "returns an empty array" do
        _(Microstation.get_text(drawing_no_text)).must_equal([])
      end
    end
  end
end
