module Microstation
  module Properties
    def author=(var = nil)
      if var
        @ole_obj.Author = var
      else
        begin
          @ole_obj.Author
        rescue
          nil
        end
      end
    end

    alias_method :author, :author=

    def subject=(var = nil)
      if var
        @ole_obj.Subject = var
      else
        begin
          @ole_obj.Subject
        rescue
          nil
        end
      end
    end

    alias_method :subject, :subject=

    def comments=(var = nil)
      if var
        @ole_obj.Comments = var
      else
        begin
          @ole_obj.Comments
        rescue
          nil
        end
      end
    end

    alias_method :comments, :comments=

    def title=(var = nil)
      if var
        @ole_obj.Title = var
      else
        begin
          @ole_obj.Title
        rescue
          nil
        end
      end
    end

    alias_method :title, :title=

    def keywords=(var = nil)
      if var
        @ole_obj.Keywords = var
      else
        begin
          @ole_obj.Keywords
        rescue
          nil
        end
      end
    end

    alias_method :keywords, :keywords=
  end
end
