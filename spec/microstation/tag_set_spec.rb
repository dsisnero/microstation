# frozen_string_literal: true

require_relative "../spec_helper"

describe "Lets start the Microstation once" do
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

  describe "a new drawing" do
    let(:drawing) { new_drawing("temp.dgn", seedfile: "seed2d") }

    describe "creating a new tag set" do
      let(:tagsets) { drawing.tagsets }

      it "should have no initial tagsets" do
        _(tagsets.size).must_equal 0
      end

      it "should create a tagset" do
        ts = tagsets.create("test")
        _(ts).must_be_instance_of Microstation::TagSet
      end

      it "should be the same as a found tagset" do
        ts = tagsets.create("test")
        _(tagsets["test"]).must_equal ts
      end

      it "should allow you to remove a tagset" do
        tagsets.create("test")
        _(tagsets.size).must_equal 1
        tagsets.remove("test")
        _(tagsets.size).must_equal 0
      end
    end

    describe "A TagSet" do
      let(:drawing) { new_drawing("temp.dgn", seedfile: "seed2d") }

      describe "#create_tagset" do
        it "should allow you to create" do
          ts = drawing.create_tagset("faatitle")
          _(ts).must_be_instance_of Microstation::TagSet
        end

        it "should yield to block if block_given" do
          drawing.create_tagset("faatitle") do |ts|
            _(ts).must_be_instance_of Microstation::TagSet
          end
        end

        describe "given a TagSet" do
          let(:tagset) { drawing.create_tagset("faatitle") }

          it "should initially have no attributes" do
            _(tagset.attributes).must_be_empty
          end

          it "#add_attribute adds TS::Attribute" do
            _(tagset.attributes).must_be_empty
            td = tagset.add_attribute("title", String, prompt: "My title")
            _(td.prompt).must_equal("My title")
            _(tagset.attributes.size).must_equal 1
            _(td).must_be_instance_of Microstation::TS::Attribute
          end

          it "should exist and can be found in drawing" do
            tagset_local = tagset
            ts = drawing.find_tagset("faatitle")
            _(ts.name).must_equal tagset_local.name
          end
        end

        describe "given a tagset with tag defintions" do
          let(:tagset) { drawing.create_tagset("faatitle") }

          before do
            tagset.add_attribute("title", String)
            tagset.add_attribute("city", String)
          end

          describe "#attributes" do
            it "should have the correct size" do
              _(tagset.attributes.size).must_equal 2
            end

            it "#attributes should be Array of TS::Attributes" do
              tagset.attributes.each do |ta|
                _(ta).must_be_instance_of Microstation::TS::Attribute
              end
            end
          end

          describe "#attribute_names" do
            it "returns an array of the correct names" do
              _(tagset.attribute_names).must_equal %w[title city]
            end
          end

          describe "#[]" do
            it "should allow you to retrieve a tagset definition that exists" do
              _(tagset["title"]).must_be_instance_of Microstation::TS::Attribute
            end

            it "returns nil if attribute doesn't exist" do
              _(tagset["bogus"]).must_be_nil
            end
          end
        end
      end
    end
  end

  describe "a drawing with tagsets placed in drawing" do
    let(:drawing) { open_existing_drawing("drawing_with_block.dgn") }
    let(:tagsets) { drawing.tagsets }
    let(:tset) { tagsets.first }

    it "has tagsets" do
      _(tagsets).wont_be_empty
    end

    it "has the correct tagsets" do
      _(tagsets.size).must_equal 1
      _(tset.name).must_equal "electrical_panel_42"
    end

    it "has tagset instances" do
      _(tset.instances.size).must_equal 1
      tagset_instance = tset.instances.first
      _(tagset_instance.name).must_equal "electrical_panel_42"
      _(tagset_instance).must_be_instance_of Microstation::TS::Instance
    end
  end

  describe "a drawing with 3 instances of same tagset in drawing" do
    let(:drawing) { open_existing_drawing("drawing_with_3_block.dgn") }
    let(:tagsets) { drawing.tagsets }
    let(:tset) { tagsets.first }

    it "has the correct number of tagsets" do
      _(tagsets.size).must_equal 1
      _(tagsets.names).must_equal %w[electrical_panel_42]
      _(tset.name).must_equal "electrical_panel_42"
    end

    it "has the correct instances" do
      _(tset.instances.size).must_equal 3
      _(tset.instances.map(&:name)).must_equal %w[electrical_panel_42 electrical_panel_42 electrical_panel_42]
    end
  end
end
