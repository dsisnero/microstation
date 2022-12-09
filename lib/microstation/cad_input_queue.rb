require_relative 'ole_cad_input_message'
require 'dry/monads'
module Microstation
  class CadInputQueue
    include Dry::Monads[:result]

    attr_reader :app, :ole_obj

    def initialize(ole_obj, app)
      @ole_obj = ole_obj
      @app = app
      @input_procs = []
    end

    def <<(string)
      send_keyin(string)
    end

    def send_keyin(string)
      @ole_obj.SendKeyin(string)
    end

    def send_reset
      @ole_obj.SendReset
    end

    def close
      @ole_ojb = nil
    end

    def send_command(text)
      @ole_obj.SendCommand(text)
    end

    def send_data_point(pt)
      @ole_obj.SendDataPoint app.to_ole_point3d(pt)
    end

    def send_tentative_pt(pt)
      @ole_obj.SendTentativePoint(pt)
    end

    def send_drag_points(down_pt, up_point, view_specifier: nil, qualifier: nil)
      @ole_obj.SendDragPoints(down_pt, up_point)
    end

    def get_input(*args)
      com = @ole_obj.GetInput(*args)
      OLE_CadInputMessage.new(com, app)
    end

    def get_point(prompt: 'Enter vertex')
      show_prompt(prompt)
      mycim = get_input(InputType::DataPoint, InputType::Reset)
      if mycim.reset?
        clear_ui
        Failure(:reset_pressed)
      elsif mycim.data_point?
        clear_ui
        Success(mycim.get_point)
      end
    end

    def show_command(text)
      app.show_command(text)
    end

    def show_prompt(text)
      app.show_prompt(text)
    end

    def show_status(text)
      app.show_status(text)
    end

    def clear_ui
      app.show_prompt('')
      app.show_status('')
      app.show_command('')
    end

    def method_missing(name, *args, &block)
      @ole_obj.send(name, *args, &block)
    end

    def start_default_command
      @app.ole_obj.CommandState.StartDefaultCommand
    end
  end
end
