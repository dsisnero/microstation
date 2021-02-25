# frozen_string_literal: true

require_relative '../spec_helper'

$LOAD_PATH.unshift(File.join(__dir__, '../lib'))

# require 'minitest/spec'
# require 'minitest/autorun'

describe 'Lets start the Microstation once' do
  include Minitest::Hooks
  before(:all) do
    @app = Microstation::App.new
    config_app(@app)
  end

  after(:all) do
    @app.quit rescue nil
  end

  describe 'a drawing created with app.new drawing' do
    let(:drawing) { new_drawing('temp.dgn', seedfile: 'seed2d') }

    it 'should be active drawing' do
      _(drawing).must_be :active?
    end

    it 'should have an ole_obj' do
      _(drawing.ole_obj).must_be_instance_of WIN32OLE
    end

    describe '#author' do
      it "should be '' for new drawing" do
        skip
        _(drawing.author).must_equal ''
      end

      it 'should set author if given a new author' do
        drawing.author = 'A newer author'
        _(drawing.author).must_equal 'A newer author'
      end
    end

    describe '#title' do
      it "should be '' to start" do
        expect(drawing.title).must_equal('')
      end

      it 'should set title if given a new title' do
        drawing.title = 'a new title'
        expect(drawing.title).must_equal 'a new title'
      end
    end

    describe '#keywords' do
      it 'should be empty string to start' do
        _(drawing.keywords).must_equal ''
      end

      it 'should set keywords if given a string of words' do
        drawing.keywords = 'project, rcl, new'
        _(drawing.keywords).must_equal 'project, rcl, new'
      end
    end

    describe '#comments' do
      it 'should be nil to start' do
        _(drawing.comments).must_equal ''
      end

      it 'should be able to be set' do
        drawing.comments = 'these are comments'
        _(drawing.comments).must_equal 'these are comments'
      end
    end

    it 'should be able to save as pdf' do
      drawing.save_as_pdf
    end

    describe 'revision count' do
      it 'should have a revision_count' do
        _(drawing).must_respond_to(:revision_count)
      end

      it 'should forward revision count to ole_obj' do
        skip
        ole = drawing.ole_obj
        ole.stub :DesignRevisionCount, true do
          assert drawing.revision_count
        end
      end
    end

    describe 'pdf_name' do
      describe 'with no args' do
        it 'should equal the drawing path with ext changed' do
          drawing.stub(:name, 'Drawing Name.dgn') do
            _(drawing.pdf_name.to_s).must_equal 'Drawing Name.pdf'
          end
        end
      end

      describe 'with  arg for name' do
        it 'should equal the arg and the current directory' do
          _(drawing.pdf_name('my_drawing').to_s).must_equal('my_drawing.pdf')
        end
      end
    end

    describe 'save_as_pdf' do
      it 'should find the pdf name with pdf_name rules' do
        skip
        path = drawing.path
        _(drawing).to receive(:pdf_name).with('testfile', nil)
        drawing.save_as_pdf('testfile')
      end
    end

    describe 'scanning' do
      it 'should have a #create_scanner' do
        scanner = drawing.create_scanner(:test)
        _(scanner).must_be_instance_of Microstation::Scan::Criteria
      end

      it 'should scan the drawing' do
        scanner = drawing.create_scanner(:test) do |scan|
          _(scan).must_be_instance_of Microstation::Scan::Criteria
        end
        drawing.scan_model(scanner)
      end
    end

    describe '#scan_text' do
      it 'only yields textual items' do
        drawing.scan_text do |item|
          _(item.class).must_equal(Microstation::Text || Microstation::TextNode)
        end
      end
    end

    describe '#update_tagset' do
      describe 'when 1 block exists' do
      end

      describe 'when 1 block not in default drawing' do
        let(:drawing) { new_drawing('test.dgn', seedfile: 'drawing_faatitle_in_non_default_model.dgn') }
        let(:app) { @app }

        it 'finds tagsets in drawing' do
          tagsets = drawing.tagsets_in_drawing.to_a
          _(tagsets.size).must_be :>, 0
        end

        it 'updates tagset' do
          ts = drawing.find_tagset_instance_by_name('faatitle')
          ts_title = ts['title1'].to_s
          _(ts_title).must_equal('TITLE 1')
          drawing.update_tagset('faatitle', { 'title1' => 'MY NEW TITLE' })
          ts = drawing.find_tagset_instance_by_name('faatitle')
          _(ts['title1'].to_s).must_equal('MY NEW TITLE')
        end
      end
      describe 'when multiple blocks' do
        let(:drawing) { new_drawing('test.dgn', seedfile: 'drawing_with_3_block.dgn') }
        let(:panel_atts) { { 'brk_1_service' => 'OUTLETS', 'brk_2_service' => 'AIR CONDITIONER' } }
        let(:app) { @app }

        before do
          before_new_drawing
        end

        describe '#save_tagsets' do
          it 'saves the atts to a file' do
            drawing.save_tagsets_to_file("#{Microstation::ROOT}drawing_atts.txt")
          end
        end

        describe 'with no microstation_id' do
          it 'errors' do
            _ { drawing.update_tagset('electrical_panel_42', panel_atts) }.must_raise Microstation::MultipleUpdateError
          end
        end

        describe 'when multiple blocks exist and microstation_id' do
          it 'updates drawing with block' do
            ts = drawing.find_tagset_instance_by_name_and_id('electrical_panel_42', 324)
            _(ts.brk_1_service).must_equal('')
            _(ts.brk_2_service).must_equal('')
            panel = panel_atts.merge({ 'microstation_id' => 324 })
            drawing.update_tagset('electrical_panel_42', panel)
            ts = drawing.find_tagset_instance_by_name_and_id('electrical_panel_42', 324)
            _(ts.brk_2_service).must_equal('AIR CONDITIONER')
            _(ts.brk_1_service).must_equal('OUTLETS')
          end
        end
      end
    end
    describe '#get_text' do
      describe 'drawing with no text' do
        let(:drawing) { open_existing_drawing('drawing_no_block.dgn') }
        it 'returns empty array if text has no text' do
          _(drawing.get_text.to_a).must_equal([])
        end
      end

      describe 'drawing_with_text in block' do
        let(:drawing) { open_existing_drawing('drawing_with_block.dgn') }
        let(:text_in_drawing) do
          ['text1 {{ a1 }}',
           'text2 {{ a2 }}',
           'text3 {{ a3 }}',
           "node1 {{ a4 }}\nnode1 {{ a5 }}",
           "node2 {{ a7 }}\nnode2 {{ a7 }}",
           'text a1 again {{ a1 }}']
        end

        it 'gets all the text if drawing has text' do
          text_from_drawing = drawing.get_text
          _(text_from_drawing.to_a.sort).must_equal(text_in_drawing.sort)
        end
      end
    end

    describe '2d and 3d' do
      describe 'when have a 2d drawing' do
        let(:drawing) { new_drawing('temp.dgn', seedfile: 'seed2d') }

        it 'should  be 2d and not 3d two_d? ' do
          _(drawing).must_be :two_d?
          _(drawing).wont_be :three_d?
        end
      end

      describe 'when we have a 3d drawing' do
        let(:drawing) { new_drawing('temp.dgn', seedfile: 'seed3d') }

        it 'should be 3d and not 2d' do
          _(drawing).must_be :three_d?
          _(drawing).wont_be :two_d?
        end
      end
    end
  end
end
