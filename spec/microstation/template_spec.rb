# frozen_string_literal: true

require_relative "../spec_helper"
require "fileutils"
require "digest/md5"

require "minitest/spec"
require "minitest/autorun"

require "microstation"

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

  describe "initialization" do
    it "needs a drawing argument" do
      assert_raises { Microstation::Template.new }
    end

    it "requires a valid and existing  microstation file" do
      %w[draw.dgn file://adoc.doc file://anexcel.xls file://autocad.dwg].each do |ftype|
        assert_raises { Microstation::Template.new(ftype) }
      end
    end

    describe "given a good dgn file and file exists" do
      let(:file) { "file.dgn" }

      it "does not error" do
        mock = Minitest::Mock.new
        mock.expect(:file?, true)
        File.stub :file?, true do
          Microstation::Template.new(file)
        end
      end

      it "sets the template" do
        mock = Minitest::Mock.new
        mock.expect(:file?, true)
        File.stub :file?, true do
          temp = Microstation::Template.new(file)
          _(temp.template).must_equal(file)
        end
      end
    end
  end

  describe "a drawing with tags" do
    before do
      @dgn_name = "drawing_with_block.dgn"
      @dgn_file = drawing_path("drawing_with_block.dgn")
      @template = Microstation::Template.new(@dgn_file)
    end

    subject { @template }

    describe ".render" do
      let(:dgn_name) { @dgn_name }
      let(:template) { @template }
      let(:dgn_file) { @dgn_file }
      let(:copied_file) { drawing_path("copied_file.dgn") }
      let(:output_file) { output_path(dgn_name) }
      let(:changed_name) { "changed_name.dgn" }
      let(:locals) do
        {"a1" => "change 1", "a2" => "change 2",
         "a3" => "c3", "a4" => "c4"}
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

      it "accepts options hash" do
        template.render(output_dir: OUTPUT_DIR, options: {visible: true})
      end

      describe "when locals or tagsets not input" do
        it "does nothing unless either locals or tagsets" do
          template.render(output_dir: OUTPUT_DIR)
          _(File.file?(output_file)).must_equal false
        end
      end

      describe "when locals or tagset is set" do
        it "creates a file" do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(File.file?(output_file)).must_equal true
        end

        it "changes text" do
          template.render(output_dir: OUTPUT_DIR,
            locals: {"a1" => "change 1", "a2" => "change 2", "a3" => "c3", "a4" => "c4"})
          text = Microstation.get_text(output_file)
          ["text1 change 1", "text2 change 2", "text3 c3", "node1 c4\nnode1 ", "node2 \nnode2 ",
            "text a1 again change 1"].each do |t|
              _(text).must_include(t)
            end
        end

        it "doesn't change input file" do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(FileUtils.compare_file(dgn_file, copied_file)).must_equal true
        end

        it "changes the output" do
          template.render(output_dir: OUTPUT_DIR, locals: locals)
          _(FileUtils.compare_file(output_file, copied_file)).must_equal false
        end
      end
      describe "a drawing with liquid blocks in cells " do
        # before :all do
        #   @dgn_file = drawing_path('drawing_with_block.dgn')
        #   @template = Microstation::Template.new(@dgn_file)
        # end

        let(:filename) { "drawing_with_liquid_in_cell.dgn" }
        let(:drawing_file) { drawing_path(filename) }
        let(:template) { Microstation::Template.new(drawing_file) }
        let(:output_file) { output_path(filename) }
        let(:locals) { {"fx" => "121.59"} }

        before do
          FileUtils.rm(output_file) if File.exist? output_file
        end


        it "updates the cells liquid text" do
          template.render(output_dir: OUTPUT_DIR, locals: locals, options: {visible: true})
          Microstation.run(visible: true) do |app|
            drawing = app.open_drawing(output_file)
            result = drawing.get_text_in_cells
            _(result).must_include("121.59 TX Main")
            _(result).must_include("121.59 Rx Main")
            _(result).must_include("121.59 TX Stby")
            _(result).must_include("121.59 Rx Stby")
          end
        end
      end


      describe "a drawing with multiple blocks of the same block" do
        # before :all do
        #   @dgn_file = drawing_path('drawing_with_block.dgn')
        #   @template = Microstation::Template.new(@dgn_file)
        # end

        let(:filename) { "drawing_with_3_block.dgn" }
        let(:drawing_file) { drawing_path(filename) }
        let(:template) { Microstation::Template.new(drawing_file) }
        let(:output_file) { output_path(filename) }
        let(:panel) {
          {"brk_1_service" => "OUTLETS",
           "brk_2_service" => "AIR CONDITIONER"}
        }

        before do
          FileUtils.rm(output_file) if File.exist? output_file
        end

        it "errors if not given microstation_id to distinguish" do
          old_proc = Microstation::App.default_error_proc
          Microstation::App.default_error_proc = ->(e, f) { raise e }
          _ { template.render(output_dir: OUTPUT_DIR, tagsets: [{"electrical_panel_42" => panel}]) }.must_raise(Microstation::MultipleUpdateError)
          Microstation::App.default_error_proc = old_proc
        end


        it "updates the drawing_blocks if given id" do
          panel_with_id = panel.merge("microstation_id" => 324)
          template.render(output_dir: OUTPUT_DIR, tagsets: [{"electrical_panel_42" => panel_with_id}])
          Microstation.run(visible: true) do |app|
            drawing = app.open_drawing(output_file)
            ts = drawing.find_tagset_instance_by_name_and_id("electrical_panel_42", 324)
            _(ts.brk_1_service).must_equal("OUTLETS")
            _(ts.brk_2_service).must_equal("AIR CONDITIONER")
          end
        end
      end
    end
  end
end
