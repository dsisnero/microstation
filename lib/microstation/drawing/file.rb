module Microstation


  class Drawing

    class File < BasicObject

      def self.drawing_file
        file.to_s =~  /d[gn,wg]\Z/
      end


      extend Forwardable

      def_delegators :@app, :cad_input_queue, :create_scanner, :scan, :eval_cexpression
      def_delegators :@path,


      def_win_delegators :@ole_obj, :IsActive, :Save, :Name, :Close

      def initialize(path)
        # make sure a drawing file
        @path = Pathname(path)
      end

      def app=(app)
      end

      def ole_obj=(ole_obj)
      end

      def to_windows_path
      end

      def open_drawing(options = {})
        @ole_obj = app.ole_open_drawing( self.to_windows_path, options)
        return self unless block_given?
        begin
          yield self
        rescue
          self.close
        end
      end

      def create_drawing(options = {})
        raise 'Drawing Exists?' if self.exists?
      end

      def create_copy(options = {})
      end

      def close
        @ole_obj.Close if open?
      end

      def open?
        @ole_obj  # && @ole_obj.Open?
      end

      def modified_date
        @ole_obj.DateLastSaved
      end

      def revision_count
        @ole_obj.DesignRevisioncount
      end


    end
  end
end










