# frozen_string_literal: true

require_relative '../spec_helper'

describe 'points by rectangle' do
  include Minitest::Hooks

  before(:all) do
  @app = Microstation::App.new(visible: true)
  config_app(@app)
  end

  after(:all) do
    delete_current_drawing
    @app.quit rescue nil
  end

  let(:app) { @app }

  it 'should be a function on app' do
    skip
    require 'pry'; binding.pry
    drawing = app.new_drawing('temp.dgn')
    pts = app.get_points_by_rectangle
    puts pts.value
  end

  describe '#points_by_line' do
    it 'should not error' do
      skip
      drawing = app.new_drawing('temp.dgn')
      require 'pry'; binding.pry
      pts = app.get_points_by_line
    end
  end
end
