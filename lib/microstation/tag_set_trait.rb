module Microstation

  module TagSetTrait

    def tagsets
      @tagsets ||= TagSets.new(self,ole_obj_tagsets)
    end

    def tagset_names
      tagsets.map{|ts| ts.name}
    end

    def reset_tagsets
      @tagsets = nil
      tagsets
    end

    def create_tagset(name,&block)
      ts = tagsets.create(name)
      reset_tagsets
      block.call ts if block
      ts
    end

    def create_tagset!(name,&block)
      remove_tagset(name)
      create_tagset(name,&block)
    end

    def remove_tagset(name)
      tagsets.remove(name)
      reset_tagsets
    end

    def find_tagset(name)
      tagsets[name]
    end

    protected

    def ole_obj_tagsets
      @ole_obj.TagSets
    end

    def ensure_tags(tags)
      tags.map{|t| t.class == WIN32OLE ? app.ole_to_ruby(t) : t }
    end

  end

end
