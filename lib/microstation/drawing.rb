require_relative 'properties'

module Microstation

  class Drawing

    include Properties

    attr_reader :app

    def initialize(app, ole)
      @app = app
      @ole_obj = ole
 #     self.author = app.username
    end

    def active?
      @ole_obj.IsActive
    end

    def cad_input_queue(&block)
      @app.cad_input_queue(&block)
    end

    def save_as_pdf(lname = nil,dir=nil)
      saved_name = pdf_name(lname,dir)
      cad_input_queue do |q|
        q << "Print Driver #{pdf_driver}"
        q << "Print Papername ANSI D"
        q << "Print BOUNDARY FIT ALL"
        q << "Print ATTRIBUTES BORDER OUTLINE OFF"
        q << "Print Attributes Fenceboundary Off"
        q << "Print Execute #{saved_name}"
      end
      puts "saved #{saved_name}"
    end

    # alias_method :title, :title=

    def create_scanner(&block)
      app.create_scanner(&block)
    end

    def scan(scanner = nil,&block)
      app.scan(scanner,&block)
    end

    def scan_graphical(&block)
      sc = create_scanner
      sc.ExcludeNonGraphical
      app.scan(sc,&block)
    end

    def scan_text(&block)
      sc = create_scanner do
        include_textual
      end
      app.scan(sc,&block)
    end

    def scan_tags(&block)
      sc = create_scanner do
        include_tags
      end
      app.scan(sc,&block)
    end

    def scan_tagset(name,&block)
      result = []
      temp = scan_tags.select{|t| t.TagSetName == name}.group_by{|t| t.BaseElement.ID64}
      temp.each do |k,tagarray|
        ole = tagarray.first.ole_base_element
        tagged_element = TaggedElement.new(ole)
        ts = tagged_element.add_tagset(name,tagarray)
        yield ts if block
        result << ts
      end
      result unless block
    end

    def find_tagset(name)
      scan_tagset(name).first
    end

    def mdate
      @ole_obj.DateLastSaved
    end
    #  alias_method :keywords , :keywords=x

    def dimensions
      eval_cexpression("tcb->ndices")
    end

    def fullname
      @ole_obj.FullName
    end

    def two_d?
      dimensions == 2
    end

    def three_d?
      dimensions == 3
    end

    def name
      @ole_obj.Name
    end

    def path
      @ole_obj.Path
    end

    def full_path
      Pathname.new(path) + self.name
    end

    def revision_count
      @ole_obj.DesignRevisionCount
    end

    def eval_cexpression(string)
      app.eval_cexpression(string)
    end

    def close
      @ole_obj.Close
    end

    def ole_obj
      @ole_obj
    end

    def pdf_name(lname = nil,dir=nil)
      pdfname = lname ? lname : self.name
      pdfname = Pathname.new(pdfname).ext('.pdf')
      pdfname = Pathname.new(dir) + pdfname if dir
      pdfname = pdfname.expand_path
      app.windows_path(pdfname)
    end

    def pdf_driver
      app.windows_path( (Microstation.plot_driver_directory + "pdf-bw.plt").to_s)
    end

    def tagset_names
      tagsets.map{|ts| ts.name}
    end

    def tagsets
      @tagsets ||= TagSets.new(@ole_obj.TagSets)
    end

    def create_tagset(name)
      ts = tagsets.create(name)
      yield ts if block_given?
      ts
    end


  end

end
