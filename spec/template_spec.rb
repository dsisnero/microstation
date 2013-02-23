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

module Microstation

  describe Template do

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
          File.stub(:file?).and_return(true)
          expect{ Microstation::Template.new(file)}.to_not raise_error

        end

        it 'sets the template' do
          File.stub(:file?).and_return(true)
          temp = Microstation::Template.new(file)
          expect( temp.template).to eq(file)
        end

      end

    end

    describe '#entry points' do

      context 'an initialized template' do
        let(:dwg_with_block){'drawing_with_block.dgn'}
        let(:template_with_block){ Template.new(drawing_path(dwg_with_block))}
        let(:dwg_no_block){ 'drawing_no_block.dgn'}
        let(:template_no_blocks){ Template.new(drawing_path(dwg_no_block))}

        describe 'entry_points' do

          it 'should return entry points if it has them' do
            template_with_block.entry_points.should ==  [
                                                         "text1 {{ a1 }}",
                                                         "text2 {{ a2 }}",
                                                         "text3 {{ a3 }}",
                                                         "node1 {{ a4 }}\nnode1 {{ a5 }}",
                                                         "node2 {{ a7 }}\nnode2 {{ a7 }}",
                                                         "text a1 again {{ a1 }}",
                                                        ]
          end

          context 'a drawing with no blocks' do

            it 'should return an empty array' do
              template_no_blocks.entry_points.should == []
            end

          end

        end

        describe '#keys_from_entry_points' do
          it 'should return the correct points' do
            points =  [
                       "text {{ a1 }}\ntext {{ a2 }}",
                       "text3 {{ a3 }}\ntext3 {{ a4 }}"
                      ]
            template_no_blocks.keys_from_entry_points(points).should == ["a1","a2","a3","a4"]
          end

          it 'should give unique keys' do
            points  = ["t1 {{  a }} again {{ a }}", "t2 {{ b }} ", "{{ b }} ", "and d {{ d }} "]
            template_no_blocks.keys_from_entry_points(points).should == ["a","b","d"]
          end
        end

        describe "#tagset_names" do
          it 'returns the tagset names'
          it 'returns the tagset attributes'

        end

      end

      describe 'rendering of template' do

        let(:dwg_name){ 'drawing_with_block.dgn'}
        let(:drawing_file){ drawing_path( dwg_name)}
        let(:output_file){ output_path( dwg_name)}
        let(:template){ Template.new( drawing_file)}
        let(:locals){{"a1" => 'change 1', "a2" => 'change 2',
            "a3"=>'c3',"a4" =>'c4'}}
        subject{ template }

        it "it doesn't error" do
          expect{ template.render({},{},OUTPUT_DIR)}.to_not raise_error
        end

        it 'creates a file' do
          expect( File.file?(output_file)).to be_true
        end


        it "changes text" do
          pending
          template.render({"a1" => 'change 1', "a2" => 'change 2',"a3"=>'c3',"a4" =>'c4'},{},OUTPUT_DIR)

          text = Microstation.get_text(out_name)
          ["text change 1/ntext change 2", "text3 c3\ntext3 c4"].each do |t|
            expect( text).to include(t)
          end

        end

      end

      describe 'changing of files' do
         let(:dwg_name){ 'drawing_with_block.dgn'}
        let(:drawing_file){ drawing_path( dwg_name)}
        let(:copied_file){ drawing_path('copied_file.dgn')}
        let(:output_file){ output_path( dwg_name)}
        let(:template){ Template.new( drawing_file)}
        let(:locals){{"a1" => 'change 1', "a2" => 'change 2',
            "a3"=>'c3',"a4" =>'c4'}}

        context 'input file change' do
          before(:each) do
            FileUtils.cp( drawing_file, copied_file)
          end

          after(:each) do
            FileUtils.rm( copied_file)
          end


          it "doesn't change input file" do
            template.render(locals,{},OUTPUT_DIR)
            expect( FileUtils.compare_file( drawing_file, copied_file)).to be_true
          end

          it "changes the output" do
            template.render(locals,{},OUTPUT_DIR)
            expect(  FileUtils.compare_file(output_file, copied_file)).to_not be_true
          end

        end

      end

    end

  end

end
