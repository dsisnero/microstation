#require_relative 'scan/scan_trait'
require 'microstation/wrap'
require_relative 'ts/tagset_trait'

module Microstation

  module CriteriaCreationT

    def text_criteria
      app.scanners[:textual] || app.create_scanner(:textual){ include_textual}
    end

    def graphic_criteria
      app.scanners[:graphical] || app.create_scanner(:graphical){ ExcludeNonGraphical}
    end

    def tags_criteria
      app.scanners[:tags] || app.create_scanner(:tags){ include_tags}
    end
  end

end

module Microstation
  module ModelTrait

    include CriteriaCreationT
   # include TS::TagSetTrait

    def name
      ole_obj.name
    end

    def find_by_id(id)
      ele = ole_obj.GetElementById64(id)
      Microstation::Wrap.wrap(ele)
    end

    def active?
      ole_obj.IsActive
    end

    def get_selected_elements
      Enumerator.new(ole_obj.GetSelectedElements)
    end

    def unselect_element(el)
      ole_obj.UnselectElement(el.ole_obj)
    end

    def select_element(el)
      ole_obj.SelectElement(el.ole_obj)
    end

    def readonly?
      ole_obj.IsReadOnly
    end

    def activate
      ole_obj.Activate
    end

    def locked?
      ole_obj.IsLocked?
    end



    def to_s
      "Microstation::Model-#{name}"
    end

    # include ScanTrait

    def create_scanner(name,&block)
      app.create_scanner(name,&block)
    end

    def scan_graphical(&block)

      self.scan(graphic_criteria,&block)
    end

    def scan_text(&block)
      self.scan(text_criteria,&block)
    end

    def scan_tags(&block)
      self.scan(tags_criteria,&block)
    end

    def scan(criteria=nil)
      criteria = criteria || create_scanner(:nullscanner)
      scan_result = ole_run_scan(criteria)
      return [] unless scan_result
      scan_enum = Microstation::Enumerator.new(scan_result)
      result =  []
      if block_given?
        scan_enum.each do |item|
          yield item
        end
      else
        scan_enum.each do |item|
          result << item
        end
      end

      return result unless block_given?
    end

    def ole_run_scan(criteria)
      criteria.resolve
      scan_result = self.ole_obj.Scan(criteria.ole_obj) rescue nil
    end



  end

  class DefaultModel

    include ModelTrait

    attr_reader :app,:ole_obj

    def initialize(app,ole)
      @app = app
      @ole_obj = ole
    end

    def drawing
      @drawing ||= Drawing.from_ole_obj(app,ole_obj)
    end


  end


  class Model

    include ModelTrait

    attr_reader :app,:drawing,:ole_obj

    def initialize(app,drawing,ole)
      @app = app
      @drawing = drawing
      @ole_obj = ole
    end

  end

end
