require File.join(File.dirname(__FILE__), 'spec_helper')
require 'fileutils'
require 'digest/md5'

require 'microstation/template_info'

describe Microstation::TemplateInfo do

  before(:all) do
    @file_with_block = drawing_path('drawing_with_block.dgn')
    @template_info = Microstation::TemplateInfo.new(@file_with_block)
  end


  describe 'initialization' do

    context 'when given a string' do

      subject{ @template_info}
      let(:dgn_file){ @file_with_block}
      # let(:dgn_name){ 'drawing_with_block.dgn'}
      # let(:dgn_file){ drawing_path(dgn_name) }
      # let!(:template_info){  Microstation::TemplateInfo.new(dgn_file) }
      # let(:dgn_file_no_block){ drawing_path('drawing_no_block.dgn')}
      # let!(:template_info_no_blocks){ Microstation::TemplateInfo.new(dgn_file_no_block) }
      let(:placeholders){ ["text1 {{ a1 }}",
                           "text2 {{ a2 }}",
                           "text3 {{ a3 }}",
                           "node1 {{ a4 }}\nnode1 {{ a5 }}",
                           "node2 {{ a7 }}\nnode2 {{ a7 }}",
                           "text a1 again {{ a1 }}",
                          ]}

      it 'correctly sets drawing_path' do
        expect(normalize_path(subject.drawing_path)).to eq(normalize_path(dgn_file))
      end

      it 'correctly sets the template string' do
        expect(normalize_path(subject.template)).to eq(normalize_path(dgn_file.to_s))
      end

      it 'correctly sets the locals hash' do
        expect(subject.locals.sort.to_h).to eq( { "a1" => "",
                                                  "a2" => "",
                                                  "a3" => "",
                                                  "a4" => "",
                                                  "a5" => "",
                                                  "a7" => ""
                                                })
      end

      it 'correctly sets the tagsets' do
        tagsets = subject.tagsets
        expect(tagsets.class).to eq Array
        expect(tagsets[0].keys).to eq(["model_name","instances"])
        expect(tagsets[0]['instances'][0].keys).to eq(['tagset_name','attributes'])
        expect(tagsets[0]['instances'][0]['tagset_name']).to eq('electrical_panel_42')
      end



    end
  end

end
