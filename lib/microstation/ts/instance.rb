class Hash
  def transform
    each_with_object({}) do |(k, v), result|
      new_k, new_v = yield k, v
      result[new_k] = new_v
    end
  end
end

module Microstation
  module TS
    class Instance
      include Enumerable

      attr_reader :elements, :tagset, :microstation_id, :microstation_model

      def initialize(ts, id, elements, model)
        @tagset = ts
        @microstation_id = id
        @elements = elements
        @microstation_model = model
      end

      def name
        tagset.name
      end

      def to_s
        "TS:Instance #{tagset.name}"
      end

      def find_attribute(name)
        @elements.find { |a| a.name == name.to_s }
      end

      def [](name)
        find_attribute(name)
      end

      def attributes
        @elements.map { |e| e.name }
      end

      def update_element(name, value)
        find_attribute(name).update(value)
      end

      def []=(name, value)
        update_element(name, value)
      end

      def element_value(name)
        find_attribute(name).value
      end

      def to_hash
        result = {}
        @elements.each do |ele|
          result[ele.name] = ele.value unless ele.value == '' || ele.value.nil?
        end
        result
      end

      def attribute_hash
        result = { 'microstation_id' => microstation_id }
        each_pair do |name, value|
          result[name] = value
        end
        result
      end

      def to_h
        result = { 'tagset_name' => tagset.name, 'microstation_id' => microstation_id,
                   'microstation_model' => microstation_model }
        result['attributes'] = attribute_hash
        result
      end

      def pair(el)
        [el.name, el.value]
      end

      def select
        result = []
        each do |el|
          k, v = pair(el)
          save = yield k, v
          result << find_attribute(k) if save
        end
        self.class.new(tagset, result)
      end

      def find(&block)
        select(&block).first
      end

      def each(&block)
        @elements.each(&block)
      end

      def each_pair
        @elements.each do |el|
          yield el.name, el.value
        end
      end

      def map_v
        each_pair do |k, v|
          new_v = yield v
          update_element(k, new_v)
        end
      end

      def update(value_hash)
        value_hash = value_hash.transform { |k, v| [k.to_s, v.to_s] }
        valid_atts = attributes & value_hash.keys
        valid_atts.each do |att|
          update_element(att, value_hash[att])
        end
      end

      def method_missing(meth, *args, &block)
        base = meth.to_s.sub('=', '')
        if attributes.include?(base)
          if meth.match(/(=)/)
            update_element(base, *args)
          else
            element_value(base.to_s)
          end
        else
          super(meth, *args, &block)
        end
      end
    end
  end
end
