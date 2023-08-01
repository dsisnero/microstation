require_relative "graphics"
require_relative "scan_trait"

module Microstation
  module ModelTrait
    include Graphics

    include ScanTrait
    # include TS::TagSetTrait

    def name
      ole_obj.name
    end

    def find_by_id(id)
      ele = begin
        ole_obj.GetElementById64(id)
      rescue
        nil
      end
      return nil unless ele
      app.ole_to_ruby(ele)
    end

    def active?
      ole_obj.IsActive
    end

    def get_selected_elements
      Enumerator.new(ole_obj.GetSelectedElements, app)
    end

    def get_selected_text
      get_selected_elements.select { |t| t.textual? }
    end

    def get_matching_text(re)
      result = []
      get_selected_text.each do |t|
        md = re.match(t)
        if md
          if block_given?
            yield t, md
          else
            result << t
          end
        end
      end
    end

    def change_text_suffix(reg, offset)
      get_matching_text(reg) do |t, md|
        pre = md[1]
        suff = Integer(md[2]) + offset
        t.replace "#{pre}#{suff}"
      end
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

    def add_element(el)
      if el.respond_to? :ole_obj
        el = el.ole_obj
        ole_obj.AddElement(el)
        self
      end
    end

    def select_tagset_instances
    end

    def scan_tags_filtered(ts_name: nil, base_element_id: nil, &block)
      case [ts_name, base_element_id]
      in [nil, nil]
        scan_tags(&block)
      in [String, nil]
        scan_tags.select { |t| t.tagset_name == ts_name }
      in [String, Numeric]
        scan_tags.select { |t| t.tagset_name == ts_name && t.base_element_id == base_element_id }
      in [nil, Numeric]
        scan_tags.select { |t| t.base_element_id == base_element_id }

      end
    end

    def tags_to_hash(tags)
      return to_enum(__callee__, tags) unless block_given?
      tsets = tags.group_by { |t| t.tagset_name }
      tsets.each do |tsname, tags|
        elements = tags.group_by { |t| t.base_element_id }
        elements.each do |id, tag_elts|
          result_hash = {
            name: tsname,
            model: name,
            tags: tag_elts,
            base_element_id: id
          }
          yield result_hash
        end
      end
    end

    def get_tagsets_in_model_hash(ts_name: nil, base_element_id: nil, &block)
      tags = scan_tags_filtered(ts_name: ts_name, base_element_id: base_element_id)
      tags_to_hash(tags, &block)
    end

    def get_tagsets_in_model_hash_old
      results = []
      tsets = scan_tags.group_by { |t| t.tagset_name }
      tsets.each do |tsname, tags|
        elements = tags.group_by { |t| t.base_element_id }
        elements.each do |id, tag_elts|
          result_hash = {
            name: tsname,
            model: name,
            tags: tag_elts,
            base_element_id: id
          }
          if block_given?
            yield result_hash
          else
            results << result_hash
          end
        end
        results unless block_given?
      end
    end

    # Scan the model with
    # @param [Scan::Criteria] criteria - the criteria to scan
    # @yield the item
    def scan_model(criteria = nil)
      #    binding.break
      criteria ||= create_scanner(:nullscanner)
      scan_result = ole_run_scan(criteria)
      return [] unless scan_result
      #   binding.break
      scan_enum = ::Microstation::Enumerator.new(scan_result, app)
      result = []
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


    private

    def ole_run_scan(criteria)
      criteria.resolve
      scan_result = begin
        ole_obj.Scan(criteria.ole_obj)
      rescue
        nil
      end
    end
  end
end
