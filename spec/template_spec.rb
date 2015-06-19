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



  describe 'a drawing with tags' do

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

  context 'a drawing with tags' do

    # before :all do
    #   @dgn_file = drawing_path('drawing_with_block.dgn')
    #   @template = Microstation::Template.new(@dgn_file)
    # end


    let(:filename){ 'drawing_with_3_block.dgn'}
    let(:drawing_file){ drawing_path(filename)}
    let(:template){ Microstation::Template.new(drawing_file)}
    let(:output_file){ output_path(filename)}

    it 'updates the drawing_blocks' do

      panel = {"brk_1_service"=>"OUTLETS",
        "brk_2_service"=>"AIR CONDITIONER",
        "microstation_id"=>324}
      template.render(output_dir: OUTPUT_DIR, tagsets: [{'electrical_panel_42'=> panel}])
      app = Microstation::App.new
      drawing = app.open_drawing(output_file)
      ts = drawing.find_tagset_with_block('electrical_panel_42'){|m,i| i.microstation_id == 324}
      expect( ts.brk_2_service).to eq('AIR CONDITIONER')

    end

  end

end
