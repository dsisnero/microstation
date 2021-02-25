module OleHelper

  def select_ole_type(name)
    if name.class == String
      name = Regexp.new(name)
    end
    reg = Regexp.new(name.source,Regexp::IGNORECASE)
    typelib.ole_classes.select do |k|
      reg =~ k.name
    end
  end

  def select_ole_method(name)
    if name.class == String
      name = Regexp.new(name)
    end
    reg = Regexp.new(name.source,Regexp::IGNORECASE)
    self.ole_methods.select do |k|
      reg =~ k.name
    end
  end

  def ole_classes
    typelib.ole_classes
  end

  def create_ole_type(type)
    WIN32OLE.new(type.guid)
  end

  def ole_classes_detail
    s = String.new
    ole_classes.sort_by{|k| k.ole_type}.each do |k|
      s << "#{k.name}\n\n"
      s << "Type: #{k.ole_type}\n"
      s << "progid: #{k.progid}\n"
      s << "quid: #{k.guid}\n"
      s << "------------\n\n"
    end
    s
  end


  def ole_methods_detail
    s = String.new
    ole_methods.each do |m|
      s << "Method #{m.name}\n\n"
      s << "dispid: #{m.dispid}\n"
      s << "Event? #{m.event?}\n"
      s << "Event interface: #{m.event_interface}\n"
      s << "invoke kind: #{m.invoke_kind}\n"
      s << "return type: #{m.return_type_detail}\n"
      s << "visible: #{m.visible?}\n"
      s << "params...\n"
      m.params.each do |p|
        s << "Param Name: #{p.name}\n"
        s << "Optional: #{p.optional?}\n"
        s << "Output? #{p.output?}\n"
        s << "Detail\n"
        s << "#{p.ole_type_detail}"
        s << "\n\n"
      end
      s << "------------\n\n"
    end
    s
  end


  def each_ole_type
    return enum_for(:each_ole_type) unless block_given?
    typelib.ole_classes.each do |t|
      yield t
    end
  end

  def get_ole_type(name)
    if name.class == String
      return ole_classes.find{|t| t.name == name}
    end
    reg = Regexp.new(name.source, Regexp::IGNORECASE)
    ole_classes.find do |t|
      t.name =~ name
    end
  end

  def typelib
    self.ole_typelib
  end


end


class WIN32OLE

  include OleHelper

end


  # def select_ole_type(name)
    #   if name.class == String
    #       name = Regexp.new(name)
    #   end
    #   reg = Regexp.new(name.source,Regexp::IGNORECASE)
    #   typelib.ole_classes.select do |k|
    #     reg =~ k.name
    #   end
    # end

    # def select_ole_method(name)
    #   if name.class == String
    #     name = Regexp.new(name)
    #   end
    #   reg = Regexp.new(name.source,Regexp::IGNORECASE)
    #   ole_obj.ole_methods.select do |k|
    #     reg =~ k.name
    #   end
    # end

    # def ole_classes
    #   typelib.ole_classes
    # end

    # def create_ole_type(type)
    #   WIN32OLE.new(type.guid)
    # end

    # def each_ole_type
    #   return enum_for(:each_ole_type) unless block_given?
    #   typelib.ole_classes.each do |t|
    #     yield t
    #   end
    # end

    # def get_ole_type(name)
    #   if name.class == String
    #     name = Regexp.new name
    #   end
    #   reg = Regexp.new(name.source, Regexp::IGNORECASE)
    #   typelib.ole_classes.find do |t|
    #     t.name =~ name
    #   end
    # end



#    alias :find_ole_type :get_ole_type

 # def typelib
    #   ole_obj.ole_typelib
    # end
