#require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'spec_helper.rb'


describe Microstation do

  context "#root" do

    subject { Microstation.root}

    it { should be_instance_of Pathname}
    it "to_s" do
      expect(subject.to_s).to eq(Pathname.getwd.to_s)
    end

  end


  describe "#run" do
    it "opens up and yields an app" do
      result = nil
      Microstation.run do |app|
        expect(app).to be_instance_of(Microstation::App)
      end
    end

    it "can be called with implicit receiver" do
      Microstation.run do |app|
        expect(app).to be_an_instance_of(Microstation::App)
      end
    end

  end

  describe "#get_text" do
    let(:drawing_with_text){ drawing_path('drawing_with_block.dgn')}
    let(:drawing_no_text){ drawing_path('drawing_no_block.dgn')}

    context 'when drawing has text' do
      it 'returns the text' do
        text  = Microstation.get_text(drawing_with_text)
        expect( text.sort()).to eq( text_for_drawing_with_block.sort())
      end
    end

    context 'when drawing has no text' do
      it 'returns an empty array' do
        expect(Microstation.get_text(drawing_no_text)).to eq( [])
      end
    end

  end
end
