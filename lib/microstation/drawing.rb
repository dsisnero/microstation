# On Error Resume Next
#   Debug.Print "AUTHOR NAME IS " & ActiveDesignFile.Author
#   Debug.Print "COMMENTS " & ActiveDesignFile.Comments
#   Debug.Print "COMP NAME " & ActiveDesignFile.Company
#   Debug.Print "KEYWORDS " & ActiveDesignFile.Keywords
#   Debug.Print "MANAGER " & ActiveDesignFile.Manager
#   Debug.Print "SUBJECT: " & ActiveDesignFile.Subject
#   Debug.Print "The title is " & ActiveDesignFile.Title
#   End Sub

#   Sub SetWritableFileProperties()
#   '  Set the standard properties
#     ActiveDesignFile.Author = "AUTHOR SET FROM VBA"
#     ActiveDesignFile.Comments = "COMMENTS FROM VBA!"
#     ActiveDesignFile.Company = "VBA COMPANY"
#     ActiveDesignFile.Keywords = "VBA KEYWORDS"
#     ActiveDesignFile.Manager = "VBA MANAGER"
#     ActiveDesignFile.Subject = "VBA SUBJECT"
#     ActiveDesignFile.Title = "TITLE SET FROM VBA"
# End Sub

# Sub GetReadOnlyFileProperties()
#     Dim totalTime As Long
#     Dim minutes As Long, seconds As Long, hours As Long, days As Long

#     On Error Resume Next

#     Debug.Print ActiveDesignFile.DateLastSaved
#     totalTime = ActiveDesignFile.TotalEditingTime
#     seconds = totalTime Mod 60
#     minutes = (totalTime \ 60) Mod 60
#     hours = (totalTime \ 3600) Mod 24
#     days = totalTime \ 86400
#     Debug.Print "Total editing time is " & days & " days, " _
#                 & hours & " hours, " & minutes & " minutes, " _
#                 & seconds & " seconds"

#     Debug.Print "Editor name: " & ActiveDesignFile.Editor
#     Debug.Print "REVISION: " & ActiveDesignFile.RevisionNumber
# End Sub



module Microstation

  
  class Drawing

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
    #  send_key_in

    # '  CadInputQueue.SendKeyin ("of= level 63; view 1")
    #             CadInputQueue.SendKeyin (pentable)
    #             If bStructures Then
    #                 CadInputQueue.SendKeyin ("Print Driver structuresborderpdf.plt")
    #             Else
    #                 CadInputQueue.SendKeyin ("Print Driver roadwayborderpdf.plt")
    #             End If
    #             CadInputQueue.SendKeyin ("Print Papername ANSI B")

    #             CadInputQueue.SendKeyin ("Print YSize 10.6 in")
    #             CadInputQueue.SendKeyin ("Print XSize 16.5 in")
    #             CadInputQueue.SendKeyin ("Print Attributes Constructions Off")
    #             CadInputQueue.SendKeyin ("Print Attributes Fenceboundary Off")
    #             CadInputQueue.SendKeyin ("Print boundary fence")
    #             sCommand = "Print Execute " & sFileName & ".pdf"
    #             'CadInputQueue.SendKeyin ("Print Execute")
    #             CadInputQueue.SendKeyin (sCommand)
    #             LogFile.writeLine ("   ," & sFileName & ", Plot Successful, " & pageFacing)


    def author=(var = nil)
      var ?  @ole_obj.Author = var : @ole_obj.Author
    end
    
    
    alias_method :author, :author=

      def subject=(var = nil)
        var ? @ole_obj.Subject = var : @ole_obj.Subject
      end

      alias_method :subject, :subject=

        def comments=(var = nil)
          var ? @ole_obj.Comments = var : @ole_obj.Comments
        end

        alias_method :comments, :comments=

          def title=(var = nil)
            var ? @ole_obj.Title = var : @ole_obj.Title
          end

          alias_method :title, :title=

            def create_scanner(&block)
              app.create_scanner(&block)
            end

            def scan(scanner = nil)
              app.scan(scanner)
            end

            def scan_text
              sc = create_scanner do |scan|
                scan.include_textual
              end
              app.scan(sc)
            end
            
            def mdate
              @ole_obj.DateLastSaved
            end    

            def keywords=(var = nil)
              var ? @ole_obj.Keywords = var : @ole_obj.keywords
            end

            alias_method :keywords , :keywords=

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
