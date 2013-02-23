
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




require 'microstation'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def drawing_path(file)
  drawing = File.join(DRAWING_DIR,file)
  File.expand_path(drawing)
end

def open_existing_drawing(app)
  app.open_drawing( drawing_path('test.dgn'))
end


