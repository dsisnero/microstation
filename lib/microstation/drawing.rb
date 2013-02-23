require_relative 'properties'
require 'pry'
module Microstation

  class Drawing

    include Properties

    attr_reader :app

    def initialize(app, ole)
      @app = app
      @ole_obj = ole
    end

    def active?
      @ole_obj.IsActive
    end

    def cad_input_queue(&block)
      @app.cad_input_queue(&block)
    end

    def save_as_pdf(name = nil, dir = nil)
      out_name = pdf_name(name,dir)
      windows_name = app.windows_path(out_name)
      cad_input_queue do |q|
        q << "Print Driver #{pdf_driver}"
        q << "Print Papername ANSI D"
        q << "Print BOUNDARY FIT ALL"
        q << "Print ATTRIBUTES BORDER OUTLINE OFF"
        q << "Print Attributes Fenceboundary Off"
        q << "Print Execute #{windows_name}"
      end
      puts "saved #{windows_name}"
    end

    def pdf_name_from_options(options = {})
      name = options.fetch(:name){ basename.ext('.pdf')}
      dir = options.fetch(:dir){ dirname}
      (dir + name).expand_path
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

    def get_text
      result = []
      scan_text do |t|
        result << t.to_s
      end
      result
    end

    def scan_tags(&block)
      sc = create_scanner do
        include_tags
      end
      app.scan(sc,&block)
    end

    def modified_date
      @ole_obj.DateLastSaved
    end
    #  alias_method :keywords , :keywords=x

    def dimensions
      eval_cexpression("tcb->ndices")
    end

    # def fullname
    #   @ole_obj.FullName
    # end

    def two_d?
      dimensions == 2
    end

    def three_d?
      dimensions == 3
    end

    def name
      @ole_obj.Name
    end

    def basename
      Pathname(name)
    end

    def dirname
      Pathname(@ole_obj.Path).expand_path
    end

    def path
      dirname + basename
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
      dname = lname ? Pathname(lname) : Pathname(self.basename)
      pdfname = dname.ext('.pdf')
      dirname = dir ? Pathname(dir) : Pathname(self.dirname)
      pdfname = (dirname + pdfname).expand_path
    end

    def pdf_driver
      app.windows_path( (Microstation.plot_driver_directory + "pdf-bw.plt").to_s)
    end

    def tagset_names
      tagsets.map{|ts| ts.name}
    end

    def tagsets
      @tagsets = TagSets.new(ole_obj_tagsets)
    end

    def create_tagset(name,&block)
      ts = tagsets.create(name)
      block.call ts if block
      ts
    end

    def create_tagset!(name,&block)
      remove_tagset(name)
      create_tagset(name,&block)
    end

    def remove_tagset(name)
      tagsets.remove(name)
    end

    def find_tagset(name)
      ts = tagsets[name]
      ts.create_instances(scan_tags)
    end

    protected
    def ole_obj_tagsets
      @ole_obj.TagSets
    end

    def ensure_tags(tags)
      tags.map{|t| t.class == WIN32OLE ? app.wrap(t) : t }
    end

    # def create_tagset_instances(name,groups)
    #   ts = tagsets[name]
    #   ts.add_instance(group) if ts
    # end

    def save
      @ole_obj.Save
    end




  end

end
