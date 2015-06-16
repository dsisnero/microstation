module Microstation

  module FileTests


    def microstation_drawing?(f)
      File.file?(f) && File.extname(f) == '.dgn'
    end

    def drawing?(f)
      File.file?(f) && drawing_type?(f)
    end


    def drawing_type?(fname)
      ext = File.extname(fname)
      ext == '.dwg' || ext == '.dgn'
    end

    def check_is_drawing(f)
      raise ArgumentError, 'File must be a dgn or dwg file' unless drawing?(f)
    end
    def check_is_dgn(f)
      raise ArgumentError, 'File must be a dgn file' unless microstation_drawing?(f)
    end
  end

end


if $0 == __FILE__

  class Test

    include Microstation::FileChecks


  end

  module Microstation

    class Test2

      include FileChecks

    end

  end

  t = Test.new
  t2 = Microstation::Test2.new

  def check_type(c,c2,f)
    puts "c.drawing_type?(#{f}) == #{c.drawing_type?(f)}"
    puts "c2.drawing_type?(#{f}) == #{c2.drawing_type?(f)}"
  end

  %w( doc.pdf doc.doc doc.rtf doc.dgn doc.dwg doc.rb).each do |f|
    check_type(t,t2,f)
  end

end
