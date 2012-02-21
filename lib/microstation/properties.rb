module Microstation

  module Properties

 def author=(var = nil)
      var ?  @ole_obj.Author = var : @ole_obj.Author
    end
    
    alias_method :author, :author=

    def subject=(var = nil)
      var ? @ole_obj.Subject = var : @ole_obj.Subject
    end
 
    alias_method :subject, :subject=

    def comments=(var = nil)
      var ? @ole_obj.Comments = var : @ole_obj.Comments
    end  

    alias_method :comments, :comments=

    def title=(var = nil)
      var ? @ole_obj.Title = var : @ole_obj.Title
    end   

    alias_method :title,:title=

    def keywords=(var = nil)
      var ? @ole_obj.Keywords = var : @ole_obj.keywords
    end

    alias_method :keywords, :keywords=

  end


end
