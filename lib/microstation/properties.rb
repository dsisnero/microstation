module Microstation
  module Properties
    def author=(var = nil)
      if var
        @ole_obj.Author = var
      else
        begin
          @ole_obj.Author
        rescue StandardError
          nil
        end
      end
    end

    alias author author=

    def subject=(var = nil)
      if var
        @ole_obj.Subject = var
      else
        begin
          @ole_obj.Subject
        rescue StandardError
          nil
        end
      end
    end

    alias subject subject=

    def comments=(var = nil)
      if var
        @ole_obj.Comments = var
      else
        begin
          @ole_obj.Comments
        rescue StandardError
          nil
        end
      end
    end

    alias comments comments=

    def title=(var = nil)
      if var
        @ole_obj.Title = var
      else
        begin
          @ole_obj.Title
        rescue StandardError
          nil
        end
      end
    end

    alias title title=

    def keywords=(var = nil)
      if var
        @ole_obj.Keywords = var
      else
        begin
          @ole_obj.Keywords
        rescue StandardError
          nil
        end
      end
    end

    alias keywords keywords=
  end
end
