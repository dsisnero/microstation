module Microstation
  class TemplateRunner
    attr_reader :file, :template_hash

    def initialize(file)
      puts "running #{file}"
      @file = file
      @template_hash = load(file)
    end

    def load(file)
      File.open(file) do |f|
        YAML.load(f)
      end
    rescue StandardError => e
      binding.pry
      puts "Could not parse YAML: #{e.message}"
    end

    def name
      template_hash[:name] || Pathname(template).basename.ext('.dgn')
    end

    def locals
      template_hash[:locals]
    end

    def tagsets
      template_hash[:tagsets]
    end

    def output_dir
      template_hash[:output_dir]
    end

    def template
      template_hash[:template]
    end

    def run_with_app(app, options = {})
      run_options = { app: app }.merge(options)
      run(run_options)
    end

    def run(options = {})
      the_template = Template.new(template)
      template_options = { output_dir: output_dir,
                           locals: locals,
                           name: name,
                           tagsets: tagsets }
      run_options = template_options.merge(options)
      the_template.render(run_options)
    rescue StandardError
      binding.pry
    end
  end
end
