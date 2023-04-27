# frozen_string_literal: true

require_relative "../spec_helper"

describe Microstation::App do
  after(:all) do
    app.quit
  rescue
    nil
  end
  describe "#initialize" do
    describe "visibility" do
      it "is invisible with no options" do
        app = Microstation::App.new
        _(app).wont_be :visible
      end

      it "can be set with option" do
        app = Microstation::App.new(visible: true)
        _(app).must_be :visible
      end
    end
  end
end

describe "an open Microstation App" do
  after(:all) do
    app.quit
  rescue
    nil
  end
  let(:app) { Microstation::App.new }

  it "loads the constants" do
    app
    _(Microstation::MSD::MsdElementTypeTag).must_equal 37
  end

  describe "#can_open?" do
    it "is true for dgn and dwg files" do
      %w[dgn dwg].each do |ext|
        name = "test.#{ext}"
        _(app.can_open?(name)).must_equal true
      end
    end

    it "is false for other filetypes" do
      %w[pdf doc jpg pgn].each do |ext|
        name = "test.#{ext}"
        _(app.can_open?(name)).wont_equal true
      end
    end
  end

  describe "open_drawing" do
    describe "when valid drawing" do
      let(:path) { drawing_path("drawing_with_text.dgn") }

      it "returns a drawing" do
        drawing = app.open_drawing(path)
        _(drawing).must_be_instance_of Microstation::Drawing
        drawing.close
      end

      describe "when given a block" do
        it "yield the drawing to the block" do
          app.open_drawing(path) do |d|
            _(d).must_be_instance_of Microstation::Drawing
          end
        end

        it "closes the drawing after block returns" do
          _(app.active_design_file).must_be_nil
          app.open_drawing(path) do |d|
            _(d).must_be_instance_of Microstation::Drawing
            _(app.active_design_file).must_be_instance_of Microstation::Drawing
          end
          _(app.active_design_file).must_be_nil
        end
      end
    end

    describe "when a non existent drawing" do
      it "raises an error" do
        _ { app.open_drawing("a_bogus_file.dgn") }.must_raise Microstation::Error
      end
    end
  end

  describe "#ole_obj" do
    it "returns an instance of the WIN32OLE" do
      _(app.ole_obj).must_be_instance_of WIN32OLE
    end
  end

  describe "#create_scanner" do
    it "can yield a Microstation::Scan::Criteria" do
      scan = app.create_scanner do |sc|
        _(sc).must_be_instance_of Microstation::Scan::Criteria
      end
    end

    it "can accept a name" do
      scanner = app.create_scanner(:my_scanner) do |sc|
        sc.include_textual
        sc.include_tags
      end
      _(scanner).must_be_instance_of Microstation::Scan::Criteria
      _(app.scanners[:my_scanner]).must_be_same_as scanner
    end
  end

  describe "#normalize_name" do
    it "returns the name if the name is absolute" do
      _(app.normalize_name("c:/my_drawings/test.dgn").to_s).must_equal "c:/my_drawings/test.dgn"
    end

    # describe "with relative path"  do
    #   let(:app){ Microstation::App.new}
    #   let(:drawing_name){ "test.dgn"}

    #   describe "when project dir is set" do
    #     app.project_dir = "c:/projects/new"
    #     _(app.normalize_name(drawing_name)).must_equal "c:/projects/new/#{drawing_name}"
    #   end

    #   describe "when project dir is not set" do
    #     _(app.normalize_name(drawing_name)).must_equal (Pathname.getwd + drawing_name).to_s
    #   end

    # end
  end

  it "has a username method" do
    _(app.username).must_equal ENV["USERNAME"]
  end

  describe "#new_drawing" do
    let(:new_path) { output_path("new_drawing.dgn") }

    after do
      app.close_active_drawing
      File.delete(new_path) if File.exist? new_path
    end

    it "needs a filename" do
      _ { app.new_drawing }.must_raise
    end

    it "raises an error if drawing exists" do
      path = drawing_path("drawing_with_text.dgn")
      _ { app.new_drawing(path) }.must_raise
    end

    it "creates a drawing if the drawing path is new" do
      drawing = app.new_drawing(new_path)
      _(drawing).must_be_instance_of Microstation::Drawing
    end

    describe "when given a block" do
      it "yields the drawing to a block if a block is given" do
        app.new_drawing(new_path) do |d|
          _(d).must_be_instance_of Microstation::Drawing
        end
      end

      it "closes drawing after block returns" do
        _(app.active_design_file).must_be_nil
        app.new_drawing(new_path) do |d|
          _(d).must_be_instance_of Microstation::Drawing
          _(app.active_design_file).must_be_instance_of Microstation::Drawing
        end
        _(app.active_design_file).must_be_nil
      end
    end
  end

  describe "render_template" do
    describe "with a valid dgn" do
      let(:dgn) { drawing_path("drawing_with_block.dgn") }

      it "completes" do
        app.render_template(dgn)
      end
    end
  end
end
