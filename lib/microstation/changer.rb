# frozen_string_literal: true

module Microstation
  class Changer
    include FileTests

    attr_reader :template, :template_filename, :the_app

    def initialize(template, output_dir: nil, app: nil, name: nil)
      check_is_dgn(template)
      @template = template
      @template_filename = File.basename(template)
      @the_app = app
      @output_dir = output_dir || default_outdir(name)
      @name = name || default_name
    end

    def ensure_output_path(odir)
      path = Pathname(odir)
      path.mkpath unless path.directory?
      path
    end

    def run(name: nil, output_dir: nil, options: {}, &block)
      lname = name || @name
      loutput_dir = output_dir || @output_dir
      output_path = ensure_output_path(loutput_dir)
      newname = output_path + lname
      tmp_dgn = the_app ? change_in_tempfile(the_app, &block) : change_once_in_tempfile(options: options, &block)
      FileUtils.mv(tmp_dgn.to_s, newname.to_s)
      puts "Saved drawing #{newname}"
    rescue => e
      puts "error in changing file"
      raise e
    end

    def change_in_tempfile(app, &block)
      path = Pathname(File.join(::Dir.tmpdir, "#{template_filename}_#{Time.now.to_i}_#{rand(1000)}"))
      app.new_drawing(path, seedfile: @template) do |drawing|
        if block
          block.call(drawing)
        else
          default_block.call(drawing)
        end
        drawing.save
      end
      path
    rescue MultipleUpdateError => e
      puts "Error while #change_into_tempfile: #{e.message}"
      raise e
    end

    def change_once_in_tempfile(options: {visible: false}, &block)
      ::Microstation.run(**options) do |app|
        change_in_tempfile(app, &block)
      end
    end

    def default_block
      ->(d) { d }
    end

    def default_outdir(_name = nil)
      Pathname.getwd
    end

    def default_name
      template_filename
    end
  end
end
