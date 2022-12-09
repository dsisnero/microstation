module Microstation
  module TS
    module TagSetTrait
      def tagsets
        @tagsets = TagSets.new(ole_obj_tagsets)
      end

      def tagset_names
        tagsets.map { |ts| ts.name }
      end

      def create_tagset(name, &block)
        ts = tagsets.create(name)
        block.call ts if block
        ts
      end

      def create_tagset!(name, &block)
        remove_tagset(name)
        create_tagset(name, &block)
      end

      def remove_tagset(name)
        tagsets.remove(name)
      end

      def find_tagset(name)
        tagsets[name]
      end

      protected

      def ole_obj_tagsets
        @ole_obj.TagSets
      end

      def ensure_tags(tags)
        tags.map { |t| t.instance_of?(WIN32OLE) ? app.wrap(t) : t }
      end
    end
  end
end
