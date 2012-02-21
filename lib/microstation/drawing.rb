require_relative 'properties'

module Microstation

  
  class Drawing

    include Properties

    attr_reader :app

    def initialize(app, ole)
      @app = app
      @ole_obj = ole
      self.author = app.username
    end

    def active?
      @ole_obj.IsActive
    end

    def cad_input_queue(&block)
      @app.cad_input_queue(&block)
    end

    def save_as_pdf(name = nil)
      name = pdf_name(name)
      cad_input_queue do |q|
        q << "Print Driver #{pdf_driver}"
        q << "Print Papername ANSI D"
        q << "Print Attributes Fenceboundary Off"
        q << "Print Execute #{name}"
      end
      
    end

   
    

    # alias_method :title, :title=

    def create_scanner(&block)
      app.create_scanner(&block)
    end

    def scan(scanner = nil)
      app.scan(scanner)
    end

    def scan_text
      sc = create_scanner do
        include_textual
      end
      app.scan(sc)
    end
    
    def mdate
      @ole_obj.DateLastSaved
    end        

    #  alias_method :keywords , :keywords=

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

    def pdf_name(lname = nil)
      pdfname = lname ? lname : self.name
      pdfname = Pathname.new(pdfname).ext('.pdf').expand_path      
      app.windows_path(pdfname)
    end
    
    def pdf_driver
      app.windows_path( (Microstation.plot_driver_directory + "pdf.plt").to_s)
    end

  end

end
