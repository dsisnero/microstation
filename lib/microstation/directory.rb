module Microstation
  def self.directory(path)
    Directory.new(path)
  end

  class Directory
    def self.drawings_in_dir(dir)
      new(dir).drawings
    end

    attr_reader :path

    def initialize(dir)
      @path = Pathname(dir).expand_path
    end

    def to_path
      path
    end

    def find_drawing(name)
      drawings.find { |pn| pn.to_s == name }
    end

    def drawings
      Pathname.glob(path + "*.d{gn,wg}")
    end

    def plot_drivers
      Pathname.glob(path + "*.pltcfg")
    end

    def cell_libraries
      Pathname.glob(path + "*.cel")
    end

    def templates
      Pathname.glob(path + "*.yaml")
    end
  end
end
