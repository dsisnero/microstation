# frozen_string_literal: true

require 'erb'
require 'microstation'
require 'liquid'
require 'fileutils'
require 'tmpdir'
require_relative 'changer'
require File.join(File.dirname(__FILE__), 'file_tests')
require File.join(File.dirname(__FILE__), 'errors')

module Microstation
  class Template
    EMPTY_ARRAY = [].freeze
    EMPTY_HASH = {}.freeze
    def initialize(template, output_dir: nil, app: nil, name: nil)
      @changer = Changer.new(template, output_dir: output_dir, app: app, name: name)
    end

    def template
      @changer.template
    end

    def render(name: nil, output_dir: nil, locals: EMPTY_HASH, tagsets: EMPTY_ARRAY)
      return if locals == EMPTY_HASH && tagsets == EMPTY_ARRAY
      @changer.run(name: name, output_dir: output_dir) do |drawing|
        locals = normalize_hash(locals)
        update_text(drawing, locals)
        update_tagsets(drawing, tagsets)
      end
    end

    def run(update = {})
      @changer.run do |drawing|
        locals = normalize_hash(update)
        return if locals == {}

        update_text(drawing, locals)
        update_tagsets(drawing, tagsets)
      end
    end

    def update_text(drawing, locals = {})
      change_template_text_normal(drawing, locals)
      change_template_text_in_cells(drawing, locals)
    end

    def change_template_text_normal(drawing, locals = {})
      drawing.scan_text do |text|
        new_text = update_liquid_text(text, locals)
        text.replace new_text if new_text != text.to_s
      end
    end

    def change_template_text_in_cells(drawing, locals = {})
      drawing.scan_cells do |c|
        c.text_elements do |text|
          new_text = update_liquid_text(text, locals)
          text.replace new_text if new_text != text.to_s
        end
      end
    end

    def update_liquid_text(text, locals)
      update_hash = normalize_hash(locals)
      compiled = ::Liquid::Template.parse(text.to_s)
      new_text = begin
                   compiled.render(update_hash)
                 rescue StandardError
                   text
                 end
    end

    def normalize_hash(scope)
      scope = scope.to_h if scope.respond_to?(:to_h)
      scope = scope.transform_keys(&:to_s) if scope.is_a? Hash
      scope
    end

    def update_tagsets(drawing, ts_arg)
      return if ts_arg == []
      return if ts_arg == {}

      ts_arg = [ts_arg] if ts_arg.instance_of?(Hash)
      ts_arg.each do |hash_pair|
        drawing.update_tagset(hash_pair.keys[0], hash_pair.values[0])
      end
    end
  end
end
