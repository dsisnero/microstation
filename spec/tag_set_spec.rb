require File.join(File.dirname(__FILE__) ,  'spec_helper')
require 'tempfile'

module Helper

  def create_temp_drawing
    file = Tempfile.new('drawing.dgn')
    file.close
    @app.new_drawing(file.path)
  end
end



describe Microstation::TagSet do

  include Helper


  before(:all) do
    @app = Microstation::App.new
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
        tagsets['test'].should be_nil
      end

      it 'should return a tagset' do
        ts = tagsets.create('test')
        ts.should be_instance_of Microstation::TagSet
      end

      it 'should be the same as a found tagset' do
        ts = tagsets.create('test')
        tagsets['test'].should == ts
      end

      it 'should allow you to remove a tagset' do
        tagsets.create('test')
        tagsets.size.should == 1
        tagsets.remove('test')
        tagsets.should be_empty
      end


    end


  end

  describe 'A Tag Set' do
    let(:app) { @app}
    let(:new_drawing){ create_temp_drawing}

    describe "#create_tagset" do

      it 'should allow you to create' do
        ts = new_drawing.create_tagset('faatitle')
        ts.should be_instance_of Microstation::TagSet
      end

      it 'should yield to block if given a block' do
        new_drawing.create_tagset('faatitle') do |ts|
          ts.should be_an_instance_of Microstation::TagSet
        end
      end

      context 'given a new TagSet' do
        let(:tagset){ new_drawing.create_tagset('faatitle')}

        it 'should have no tag_definitions' do
          tagset.definitions.should be_empty
        end

        it 'should allow you to add new definitions' do
          tagset.definitions.should be_empty
          td = tagset.definition('title', String, :prompt => 'My title')
          td.prompt.should == 'My title'
          tagset.definitions.size.should == 1
        end

      end


      context 'given a tagset with tag definitions' do
        let(:tagset){ new_drawing.create_tagset('faatitle')}
      #  let(:td1){ tagset.definition('title',String)}
       # let(:td2){ tagset.definition('city', String)}

        it 'should have correct size' do
          tagset.definitions.size.should == 0
          tagset.definition('title', String)
          tagset.definitions.size.should == 1
          tagset.definition('city',String)
          tagset.definitions.size.should == 2
        end

        it 'should allow you to retrieve a td' do
          td = tagset.definition('title', String)
          tagset['title'].should == td
        end
      end
    end




  end

end






