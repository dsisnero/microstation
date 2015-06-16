if RUBY_VERSION =~ /1\.8/
  require 'rubygems'
  require 'require_relative'
  require 'ruby-debug'
end

require 'pathname'
SPEC_DIR = Pathname(File.dirname(__FILE__)).expand_path
ROOT_DIR = SPEC_DIR.parent
DRAWING_DIR = ROOT_DIR + 'cad_files'
OUTPUT_DIR = ROOT_DIR + 'test_outdir'
TEMP_DIR =  ROOT_DIR + 'tmp'

require 'microstation'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
 # config.raise_errors_for_deprecations!
end


  def drawing_path(file)
    drawing = File.join(DRAWING_DIR,file)
    File.expand_path(drawing)
  end

  def output_path(file=nil)
    if file
      (OUTPUT_DIR + file).expand_path.to_s
    else
      OUTPUT_DIR
    end

  end

  def normalize_path(p)
    p.to_s.sub(/[c,C]:/, 'C:')
  end

  def config_app(app)
    conf = app.configuration
    conf.prepend('MS_SEEDFILES',DRAWING_DIR)
    #conf.set!('MS_DESIGNSEED','seed2d')
  end


  def open_existing_drawing(app)
    app.open_drawing( drawing_path('test.dgn'))
  end



  def text_for_drawing_with_block
    ["text1 {{ a1 }}",
     "text2 {{ a2 }}",
     "text3 {{ a3 }}",
     "node1 {{ a4 }}\nnode1 {{ a5 }}",
     "node2 {{ a7 }}\nnode2 {{ a7 }}",
     "text a1 again {{ a1 }}"
    ]
  end

["text1 {{ a1 }}",
 "text2 {{ a2 }}",
 "text3 {{ a3 }}",
 "node2 {{ a7 }}\nnode2 {{ a7 }}",
 "text a1 again {{ a1 }}",
 "node1 {{ a4 }}\nnode1 {{ a5 }}"]

  def non_existent_path(name)
    path = drawing_path(name)
    File.delete(path) if File.exist? path
    return path
  end
