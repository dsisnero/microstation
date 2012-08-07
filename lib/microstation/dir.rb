require_relative 'pdf_support'
require 'fileutils'
module Microstation

  class Dir

    include PdfSupport
    include FileUtils::Verbose

    attr_reader :dir, :relative_pdf_path

    def initialize(dir,pdf_path=nil)
      @dir = Pathname(dir).expand_path
      @relative_pdf_path = set_relative_pdf_path(pdf_path)
    end

    def self.Dir(path)
      case path
      when Microstation::Dir
        path
      else
        new(Pathname(path))
      end
    end

    def ==(other)
      self.dir == other.dir && self.relative_pdf_path == other.relative_pdf_path
    end

    def to_path
      @dir.to_path
    end

    def path
      @dir
    end

    def directory?
      path.directory?
    end

    def exist?
      path.exist?
    end


    def mkdir
      @dir.mkdir
    end

    def mkpath
      @dir.mkpath
    end

    def +(other)
      self.class.new( self.path + other)
    end


    def copy(drawing,dir)
      cp drawing, dir
    end

    def select_by_name( re)
      re = Regexp.new(re)
      drawing_files.select{|n| n.to_path =~ re}
    end


    def find_by_name(re)
      re = Regexp.new(re)
      drawing_files.find{|n| n.to_path =~ re}
    end

    def drawings
      Pathname.glob(@dir + "*.d{gn,wg}")
    end

    def sort_by(&block)
      @sort_by = block
    end

    def sort(array_of_files)
      sort_lambda = @sort_by || lambda{|f| f.path.to_s}
      array_of_files.sort_by(&sort_lambda)
    end

    def drawing_files
      return @drawing_files if @drawing_files
      set_drawing_files(drawings.map{|dwg| Microstation::Drawing::File.new(dwg)} )
      @drawing_files
    end

    def set_drawing_files(dfiles)
      @drawing_files = sort(dfiles)
    end


    def pdf_generation_complete?
      drawing_files.all?{|d| not d.needs_pdf?}
    end


    def pdf_files(dir = pdf_dirname)
      sort(drawing_files).map{|p| p.pdf_name(dir)}
    end

    def concat_pdfs(files)
      Pdftk.concat(files)
    end

    def drawing_files_needing_pdf(dir = pdf_dirname)
      drawing_files.select{|d| d.needs_pdf?(dir) }
    end

    def print_pdfs(dir = pdf_dirname)
      with_drawing_files( drawing_files_needing_pdf) do |drawing|
        drawing.save_as_pdf(:dir => dir)
      end
    end

    def generate_pdfs(dir = pdf_dirname)
      print_pdfs(dir)
      concat_pdfs(pdf_files(dir), dir + "dir.combined.drawings.pdf")
    end

    def find_pdftk(dirs = nil)
      require 'pdf_forms'
      @pdftk = PdfForms.new('e:/tools/pdftk-1.44/bin/pdftk.exe')
    end

    def pdftk
      @pdftk ||= find_pdftk(dirs= nil)
    end


    def concat_pdfs(files,name)
      pdftk.cat(files,name.to_s)
      puts "generated #{name}"
    end



    def get_meta_for_drawings
      @drawing_files = nil
      files = []
      with_drawing_files( drawings) do |drawing|
        files << Microstation::Drawing::File.from_drawing(drawing)
      end
      set_drawing_files(files)
    end

    def with_drawing_files(dwgs = drawing_files, &block)
      Microstation.with_drawings(dwgs,&block)
    end

    def pdf_dirname
      if relative_pdf_path.absolute?
        relative_pdf_path
      else
        dir + relative_pdf_path
      end
    end

    def set_relative_pdf_path(path)
      rel_path = path.nil? ? "." : path
      Pathname(rel_path)
    end


    def relative_pdf_path=(path)
      @relative_pdf_path = set_relative_path(path)
    end



  end
end

module Microstation

  class Drawing

    class File

      include PdfSupport

      attr_reader :keywords, :creator, :path

      def self.from_drawing(drawing)
        file = new(drawing.path)
        file.get_meta(drawing)
        file
      end

      def to_path
        @path.to_path
      end


      def initialize(path)
        @path = Pathname(path)
      end

      def basename
        @path.basename
      end

      def dirname
        @path.dirname
      end

      def drawing=(drawing)
        @drawing = drawing
      end

      def mtime
        self.path.mtime
      end

      def title
        @title ||= get_meta
      end

      def app_open_drawing(app, &block)
        draw = app.open_drawing(self.path,&block)
      end

      def open_drawing(&block)
        Microstation.open_drawing(self.path,&block)
      end

      def get_meta(dwg)
        @title = dwg.title
        @keywords = dwg.keywords
        @creator = dwg.creator
      end

    end


  end
end









