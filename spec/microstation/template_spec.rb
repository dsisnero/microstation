# frozen_string_literal: true

require_relative '../spec_helper'
require 'fileutils'
require 'digest/md5'

require 'minitest/spec'
require 'minitest/autorun'

require 'microstation/template'

module TestHelper
  def digest_for_path(file)
    Digest::MD5.hexdigest(File.read(file))
  end

  def file_same?(p, p2)
    digest_path(p) == digest_path(p2)
  end
end

describe Microstation::Template do
  include TestHelper

  describe 'initialization' do
    it 'needs a drawing argument' do
      assert_raises { Microstation::Template.new }
    end

    it 'requires a valid and existing  microstation file' do
      %w[draw.dgn file://adoc.doc file://anexcel.xls file://autocad.dwg].each do |ftype|
        assert_raises { Microstation::Template.new(ftype) }
      end
    end

    describe 'given a good dgn file and file exists' do
      let(:file) { 'file.dgn' }

      it 'does not error' do
        mock = Minitest::Mock.new
        mock.expect(:file?, true)
        File.stub :file?, true do
          Microstation::Template.new(file)
        end
      end

      it 'sets the template' do
        mock = Minitest::Mock.new
        mock.expect(:file?, true)
        File.stub :file?, true do
          temp = Microstation::Template.new(file)
          _(temp.template).must_equal(file)
        end
      end
    end
  end

  describe 'a drawing with tags' do
    before do
      @dgn_name = 'drawing_with_block.dgn'
      @dgn_file = drawing_path('drawing_with_block.dgn')
      @template = Microstation::Template.new(@dgn_file)
    end

    subject { @template }

    describe '.render' do
      let(:dgn_name) { @dgn_name }
      let(:template) { @template }
      let(:dgn_file) { @dgn_file }
      let(:copied_file) { drawing_path('copied_file.dgn') }
      let(:output_file) { output_path(dgn_name) }
      let(:changed_name) { 'changed_name.dgn' }
      let(:locals) do
        { 'a1' => 'change 1', 'a2' => 'change 2',
          'a3' => 'c3', 'a4' => 'c4' }
      end

      before do
        FileUtils.rm(copied_file) if File.exist? copied_file
        FileUtils.cp(dgn_file, copied_file)
        FileUtils.rm(output_file) if File.exist? output_file
        FileUtils.rm(output_path(changed_name)) if File.exist?(output_path(changed_name))
      end

      after do
        FileUtils.rm(output_file) if File.exist? output_file
        FileUtils.rm(output_path(changed_name)) if File.exist?(output_path(changed_name))
      end 

      it "it doesn't error" do
        template.render(output_dir: OUTPUT_DIR)
      end

      describe 'when locals or tagsets not input' do
        it 'does nothing unless either locals or tagsets' do
          template.render(output_dir: OUTPUT_DIR)
          _(File.file?(output_file)).must_equal false
        end
      end

      describe 'when locals or tagset is set' do
        it 'creates a file' do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(File.file?(output_file)).must_equal true
        end

        it 'changes text' do
          template.render(output_dir: OUTPUT_DIR,
                          locals: { 'a1' => 'change 1', 'a2' => 'change 2', 'a3' => 'c3', 'a4' => 'c4' })
          text = Microstation.get_text(output_file)
          ['text1 change 1', 'text2 change 2', 'text3 c3', "node1 c4\nnode1 ", "node2 \nnode2 ",
           'text a1 again change 1'].each do |t|
            _(text).must_include(t)
          end
        end

        it "doesn't change input file" do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(FileUtils.compare_file(dgn_file, copied_file)).must_equal true
        end

        it 'changes the output' do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(FileUtils.compare_file(output_file, copied_file)).must_equal false
        end
      end

      describe 'a drawing with multiple blocks of the same block' do
        # before :all do
        #   @dgn_file = drawing_path('drawing_with_block.dgn')
        #   @template = Microstation::Template.new(@dgn_file)
        # end

        let(:filename) { 'drawing_with_3_block.dgn' }
        let(:drawing_file) { drawing_path(filename) }
        let(:template) { Microstation::Template.new(drawing_file) }
        let(:output_file) { output_path(filename) }

        before do
          FileUtils.rm(output_file) if File.exist? output_file
        end

        it 'updates the drawing_blocks' do
          panel = { 'brk_1_service' => 'OUTLETS',
                    'brk_2_service' => 'AIR CONDITIONER',
                    'microstation_id' => 324 }
          template.render(output_dir: OUTPUT_DIR, tagsets: [{ 'electrical_panel_42' => panel }])
          Microstation.run do |app| 
            drawing = app.open_drawing(output_file)
            ts = drawing.find_tagset_instance_by_name_and_id('electrical_panel_42', 324)
            _(ts.brk_2_service).must_equal('AIR CONDITIONER')
          end
        end
      end
      
    end
  end
end
