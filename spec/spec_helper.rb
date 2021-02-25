# frozen_string_literal: true

require 'pathname'
SPEC_DIR = Pathname(__dir__).expand_path
ROOT_DIR = SPEC_DIR.parent
DRAWING_DIR = ROOT_DIR +  'cad_files'
OUTPUT_DIR = ROOT_DIR + 'test_outdir'
TEMP_DIR = ROOT_DIR + 'tmp'

require 'bundler/setup'
$LOAD_PATH.unshift( ROOT_DIR + 'lib')

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'microstation'
require 'pry'
def drawing_path(file)
  (DRAWING_DIR + file).expand_path
end

def output_path(file = nil)
  if file
    (OUTPUT_DIR + file).expand_path.to_s
  else
    OUTPUT_DIR
  end
end

def seedfile_path(file)
  drawing_path(file)
end

def normalize_path(p)
  p.to_s.sub(/[c,C]:/, 'C:')
end

def config_app(app)
  conf = app.configuration
  conf.prepend('MS_SEEDFILES', DRAWING_DIR)
  # conf.set!('MS_DESIGNSEED','seed2d')
end

def open_existing_drawing(name)
  path = drawing_path(name)
  raise "drawing #{name} doesn't exist" unless File.file?(path)

  @app.open_drawing(path)
end

def new_drawing(name, seedfile: 'seed2d' )
  seed_path = (drawing_path(seedfile) if seedfile)
  begin
    @app.close_active_drawing
  rescue StandardError
    nil
  end
  @path = output_path(name)
  File.delete(@path) if File.exist? @path
  @app.new_drawing(@path, seedfile: seed_path)
end

def non_existent_path(name)
  path = drawing_path(name)
  File.delete(path) if File.exist? path
  path
end

def delete_current_drawing
  if drawing = @app.current_drawing
    path = drawing.path
    begin
      @app.close_active_drawing
    rescue StandardError
      nil
    end
    begin
      File.delete path
    rescue StandardError
      nil
    end
  end
end

def before_new_drawing
  @app.close_active_drawing
  begin
    File.delete(@path)
  rescue StandardError
    nil
  end
end

# def before_new_drawing
#   @app.close_active_drawing
#   File.delete(@drawing_path) if (@drawing_path && File.exist? @drawing_path)
# end
