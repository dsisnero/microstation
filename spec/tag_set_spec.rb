require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'tempfile'
require 'pry'

module Helper

  def create_temp_drawing
    file = Tempfile.new('drawing.dgn')
    file.close
    @app.new_drawing(file.path, 'seed2d')
  end
end



describe Microstation::TagSet do

  include Helper

  before(:all) do
    @app = Microstation::App.new
    config_app(@app)
  end

  after(:all) do
    @app.close_active_drawing if @app
    @app.quit
  end

  describe 'a new drawing' do
    let(:new_drawing){ create_temp_drawing}


    context 'creating a new tag set' do
      let(:tagsets){ new_drawing.tagsets}

      it 'should have no initial tagsets' do
        expect(tagsets['test']).to be_nil
      end

      it 'should return a tagset' do
        ts = tagsets.create('test')
        expect(ts).to be_an_instance_of Microstation::TagSet
      end

      it 'should be the same as a found tagset' do
        ts = tagsets.create('test')
        expect(tagsets['test']).to eq(ts)
      end

      it 'should allow you to remove a tagset' do
        tagsets.create('test')
        expect(tagsets.size).to eq(1)
        tagsets.remove('test')
        expect(tagsets).to be_empty
      end

    end
  end

  describe 'A Tag Set' do
    let(:app) { @app}
    let(:new_drawing){ create_temp_drawing}

    describe "#create_tagset" do

      it 'should allow you to create' do
        ts = new_drawing.create_tagset('faatitle')
        expect(ts).to be_instance_of Microstation::TagSet
      end

      it 'should yield to block if given a block' do
        new_drawing.create_tagset('faatitle') do |ts|
          expect(ts).to be_an_instance_of Microstation::TagSet
        end
      end

      context 'given a new TagSet' do
        let(:tagset){ new_drawing.create_tagset('faatitle')}

        it 'should have no attributes' do
          expect(tagset.attributes).to be_empty
        end

        it 'should allow you to add new definitions' do
          expect(tagset.attributes).to be_empty
          td = tagset.add_attribute('title', String, :prompt => 'My title')

          expect(td.prompt).to eq('My title')
          expect(tagset.attributes.size).to eq(1)
        end

        it 'should be able to be found in drawing' do
          tagset_local = tagset
          ts = new_drawing.find_tagset('faatitle')
          expect(ts.name).to eq(tagset_local.name)
        end

      end


      context 'given a tagset with tag definitions' do
        let(:tagset){ new_drawing.create_tagset('faatitle')}
        #  let(:td1){ tagset.definition('title',String)}
        # let(:td2){ tagset.definition('city', String)}

        it 'should have correct size' do
          expect(tagset.attributes.size).to eq(0)
          tagset.add_attribute('title', String)
          expect(tagset.attributes.size).to eq(1)
          tagset.add_attribute('city',String)
          expect(tagset.attributes.size).to eq(2)
        end

        it 'should allow you to retrieve a td' do
          td = tagset.add_attribute('title', String)
          expect(tagset['title']).to eq(td)
        end
      end
    end

  end

  context 'a drawing with tagsets placed in drawing' do
    let(:app){ @app }
    let(:drawing_file){ drawing_path('drawing_with_block.dgn')}
    let(:drawing){ app.open_drawing(drawing_file)}


    it 'has tagsets' do
      expect( drawing.tagsets).to_not be_empty
    end

    it 'has the correct tagsets' do
      model = nil
      tagsets = nil
      tsets = drawing.tagsets_in_drawing do |m,ts|
        model = m
        tagsets = ts
      end
      expect(model).to eq('Default')
      expect(tagsets.size).to eq(1)
      ti = tagsets.first
      expect(tagsets.first.name).to eq('electrical_panel_42')
    end

    it 'gives correct tagset_hash' do
      h = drawing.tagsets_in_drawing_to_hash
      expect(h[0].keys).to eq(['model_name','instances'])
      expect(h[0]['instances'][0].keys).to eq(['tagset_name','attributes'])
    end
  end

  context 'a drawing with 3 tagsets placed in drawing' do
    let(:app){ @app}
    let(:drawing_file){ drawing_path('drawing_with_3_block.dgn')}
    let(:drawing){ app.open_drawing(drawing_file)}

    it 'has the correct tagsets' do
      model =  nil
      tagsets = nil
      tsets = drawing.tagsets_in_drawing do |m, ts|
        model = m
        tagsets = ts
      end
      expect(model).to eq('Default')
      expect(tagsets.size).to eq(3)
    end
  end



end
