require File.join(File.dirname(__FILE__), 'spec_helper')
require 'fileutils'
require 'digest/md5'

require 'microstation/template'

module TestHelper

  def digest_for_path(file)
    Digest::MD5.hexdigest(File.read(file))
  end

  def file_same?(p,p2)
    digest_path(p) == digest_path(p2)
  end

end

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
        expect(tagsets.keys).to eq(["Default"])
        expect(tagsets['Default'][0].keys).to eq(['electrical_panel_42'])
      end



    end
  end

  describe Microstation::Template do

    include TestHelper

    context 'initialization' do
      it 'needs a drawing argument' do
        expect{ Microstation::Template.new}.to raise_error
      end

      it 'requires a valid and existing  microstation file' do
        %w( draw.dgn file://adoc.doc  file://anexcel.xls file://autocad.dwg).each do |ftype|
          expect{ Microstation::Template.new(ftype)}.to raise_error
        end
      end

      context 'given a good dgn file and file exists' do
        let(:file){ 'file.dgn'}


        it 'does not error' do
          allow(File).to receive(:file?){ true }
          expect{ Microstation::Template.new(file)}.to_not raise_error

        end

        it 'sets the template' do
          allow(File).to receive(:file?){ true }
          temp = Microstation::Template.new(file)
          expect( temp.template).to eq(file)
        end

      end

    end

    describe "Initialized Template" do

      context 'a drawing with tags' do

        before :all do
          @dgn_name = 'drawing_with_block.dgn'
          @dgn_file = drawing_path('drawing_with_block.dgn')
          @template = Microstation::Template.new(@dgn_file)
        end

        subject{ @template}


        describe '.render' do
          let(:dgn_name){ @dgn_name}
          let(:template){ @template}
          let(:dgn_file){ @dgn_file }
          let(:copied_file){ drawing_path('copied_file.dgn')}
          let(:output_file){ output_path( dgn_name)}
          let(:changed_name){ 'changed_name.dgn'}
          let(:locals){{"a1" => 'change 1', "a2" => 'change 2',
              "a3"=>'c3',"a4" =>'c4'}}

          before(:each) do
            FileUtils.cp( dgn_file, copied_file)
            FileUtils.rm(output_file) if File.exist? output_file
          end

          after(:each) do
            FileUtils.rm( copied_file)
          #  FileUtils.rm(output_file) if File.exist? output_file
            FileUtils.rm( output_path(changed_name)) if File.exist?( output_path(changed_name))
          end

          it "it doesn't error" do
            expect{ template.render(output_dir: OUTPUT_DIR)}.to_not raise_error
          end

          it 'creates a file' do
            template.render(output_dir: OUTPUT_DIR)
            expect( File.file?(output_file)).to be_truthy
          end

          it "changes text" do
            template.render(output_dir: OUTPUT_DIR, locals: {"a1" => 'change 1', "a2" => 'change 2',"a3"=>'c3',"a4" =>'c4'})
            text = Microstation.get_all_text(output_file)
            binding.pry if text.nil?
            ["text1 change 1","text2 change 2", "text3 c3","node1 c4\nnode1 ", "node2 \nnode2 ", "text a1 again change 1"].each do |t|
              expect( text).to include(t)
            end

          end

          it "doesn't change input file" do
            template.render(output_dir: OUTPUT_DIR,locals: locals)
            expect( FileUtils.compare_file( dgn_file, copied_file)).to be_truthy
          end

          it "changes the output" do
            template.render(output_dir: OUTPUT_DIR,locals: locals)
            expect(  FileUtils.compare_file(output_file, copied_file)).to be_falsey
          end



          #    let(:dgn_name){ 'drawing_with_block.dgn'}
          #   let(:dgn_file){ drawing_path(dgn_name) }
          #  let(:template){  Microstation::Template.new(dgn_file)}

          let(:placeholders){ ["text1 {{ a1 }}",
                               "text2 {{ a2 }}",
                               "text3 {{ a3 }}",
                               "node1 {{ a4 }}\nnode1 {{ a5 }}",
                               "node2 {{ a7 }}\nnode2 {{ a7 }}",
                               "text a1 again {{ a1 }}",
                              ]}

        end

      end
    end

  end


  context 'a drawing with no tags' do

    before :all do
      @dgn_file = drawing_path('drawing_no_block.dgn')
      @template = Microstation::Template.new(@dgn_file)
    end


    let(:dgn_file_no_block){ drawing_path('drawing_no_block.dgn')}
    let(:template_no_blocks){ Microstation::Template.new(dgn_file_no_block) }

    #   # describe '#entry points' do

    #   #   context "when template has placeholders" do


    #   #     it 'should return entry points' do
    #   #       entrypoints = template.entry_points
    #   #       expect(entrypoints.sort).to eq placeholders.sort
    #   #     end

    #   #     context 'when template has no entrypoints' do

    #   #       it 'should return an empty array' do
    #   #         expect(template_no_blocks.entry_points).to eq []
    #   #       end

    #   #     end

    #   #   end

    #   #   describe '#keys_from_entry_points' do
    #   #     it 'should return the correct points' do
    #   #       points =  [
    #   #                  "text {{ a1 }}\ntext {{ a2 }}",
    #   #                  "text3 {{ a3 }}\ntext3 {{ a4 }}"
    #   #                 ]
    #   #       expect(template_no_blocks.keys_from_entry_points(points)).to eq ["a1","a2","a3","a4"]
    #   #     end

    #   #     it 'should give unique keys' do
    #   #       points  = ["t1 {{  a }} again {{ a }}", "t2 {{ b }} ", "{{ b }} ", "and d {{ d }} "]
    #   #       expect(template_no_blocks.keys_from_entry_points(points)).to eq ["a","b","d"]
    #   #     end
    #   #   end

    #   #   describe "#tagset_names" do
    #   #     it 'returns the tagset names'
    #   #     it 'returns the tagset attributes'

    #   #   end

    # end



  end

end
