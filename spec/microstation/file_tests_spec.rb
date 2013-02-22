require File.join(File.dirname(__FILE__), '../spec_helper')


class Test

  include Microstation::FileTests


end

module Microstation
  describe FileTests do
    let(:klass){ Test.new}
    let(:non_drawing_files){%w( file.doc file.xls file.rtf file.rb)}
    let(:autocad_files){ %w( d.dwg d2.dwg d3.dwg)}
    let(:dgn_files){ %w( d.dgn d2.dgn d3.dgn)}
    let(:non_dgn_files){ non_drawing_files + autocad_files}
    let(:drawing_files){ autocad_files + dgn_files}

    subject{ klass}

    describe '#drawing_type?' do

      it "is false for non dwg or dgn files" do
        non_drawing_files.each do |f|
          expect( subject.drawing_type?(f)).to be_false
        end
      end

      it "is true for dwg and dgn files" do
        drawing_files.each do |f|
          expect( subject.drawing_type?(f)).to be_true
        end
      end

    end


    describe 'microstation_drawing?' do

      it "is false for non dgn files that are files" do
        File.stub(:file?).and_return true
        non_dgn_files.each do |f|
          expect( subject.microstation_drawing?(f)).to be_false
        end
      end

      it "is true for dgn files that exist" do
        File.stub(:file?).and_return true
        dgn_files.each do |f|
          expect( subject.microstation_drawing?(f)).to be_true
        end
      end

      it "is false for dgn files that don't exist" do
        dgn_files.each do |f|
          expect( subject.microstation_drawing?(f)).to be_false
        end
      end


    end


    describe "#drawing?" do
      it "is false for non drawing files that exist" do
        File.stub(:file?).and_return true
        non_drawing_files.each do |f|
          expect( subject.drawing?(f)).to be_false
        end
      end

      it "is true for drawing files that exist" do
        File.stub(:file?).and_return true
        drawing_files.each do |f|
          expect( subject.drawing?(f) ).to be_true
        end
      end

      it "is false for drawing_files that don't exist" do
        drawing_files.each do |f|
          expect( subject.drawing?(f)).to be_false
        end
      end


    end


  end

end











