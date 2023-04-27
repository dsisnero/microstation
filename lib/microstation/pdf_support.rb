module Microstation
  module PdfSupport
    def pdf_name(output_dir = nil)
      name = basename
      dir = output_dir || dirname
      pdfname = Pathname(name).ext("pdf")
      (dir + pdfname).expand_path
    end

    def pdf_exists?(output_dir = nil)
      pdf_name(output_dir).file?
    end

    def file_exists?(file)
      file.file?
    end

    def needs_pdf?(output_dir = nil)
      pdf_path = pdf_name(output_dir)
      !file_exists?(pdf_path) || pdf_older?(pdf_path)
    end

    def pdf_older?(pdf)
      mtime > pdf.mtime
    end

    def mtime
      path.mtime
    end
  end
end
