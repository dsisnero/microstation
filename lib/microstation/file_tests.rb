module Microstation
  module FileTests
    def microstation_drawing?(f)
      return true if drawing_dgn?(f)

      f = f&.to_path&.to_str
      drawing_dgn?(f)
    end

    def drawing_dgn?(f)
      File.file?(f) && File.extname(f) == '.dgn'
    end

    def drawing?(f)
      return true if drawing_type?(f)

      f = f&.to_path&.to_str
      drawing_type(f)
    end

    def drawing_type?(f)
      File.file?(f) && (File.extname(f) == '.dgn' || File.extname(f) == '.dwg')
    end

    def check_is_drawing(f)
      raise ArgumentError, 'File must be a dgn or dwg file' unless drawing?(f)
    end

    def check_is_dgn(f)
      raise ArgumentError, 'File must be a dgn file' unless microstation_drawing?(f)
    end
  end
end
