module Microstation
  module InputType
    COMMAND = 1
    DATA_POINT = 3
    KEYIN = 4
    ANY = 5
    UNASSIGNED = 6
  end

  class OLE_CadInputMessage
    include WIN32OLE::VARIANT
    attr_reader :lastargs, :ole_obj, :app

    def initialize(ole, app)
      @ole_obj = ole
      @app = app
    end

    def reset?
      input_type == InputType::Reset
    end

    def command?
      input_type == InputType::COMMAND
    end

    def data_point?
      input_type == InputType::DATA_POINT
    end

    def key_in?
      input_type == InputType::KEYIN
    end

    def any?
      input_type == InputType::ANY
    end

    def unassigned?
      input_type == InputType::UNASSIGNED
    end

    def input_type
      @input_type ||= get_input_type
    end

    # MsdCadInputType InputType
    def get_input_type()
      ole_obj.InputType
    end

    # BSTR Keyin
    def get_keyin()
      ret = ole_obj._getproperty(1610743809, [], [])
      @lastargs = WIN32OLE::ARGV
      ret
    end

    # Point3d Point
    def get_point()
      app.to_point3d(ole_obj.Point)
    end

    # BSTR CommandKeyin
    def get_command_keyin()
      ret = ole_obj._getproperty(1610743811, [], [])
      @lastargs = WIN32OLE::ARGV
      ret
    end

    # _View View
    def get_view()
      ret = ole_obj._getproperty(1610743812, [], [])
      @lastargs = WIN32OLE::ARGV
      ret
    end

    # Point3d ScreenPoint
    def get_screen_point()
      ret = ole_obj._getproperty(1610743813, [], [])
      @lastargs = WIN32OLE::ARGV
      ret
    end

    # I4 CursorButton
    def get_cursor_button()
      ret = ole_obj._getproperty(1610743814, [], [])
      @lastargs = WIN32OLE::ARGV
      ret
    end
  end

end
