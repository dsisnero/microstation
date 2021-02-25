require 'dry/monads'
module Microstation

  class App
    include Dry::Monads[:result]
  end

  module Functions

    extend Dry::Monads[:result]

    def get_points_by_rectangle
      queue = cad_input_queue
      queue.show_command('Get points by block')
      start_point = queue.get_point
      if start_point.failure?
        return Failure(:point1_reset)
      end
      queue.send_command "PLACE BLOCK"
      queue.send_data_point start_point.value!
      end_point = queue.get_point
      if end_point.failure?
        return Failure(:point2_reset)
      end
      Success([start_point.value!, end_point.value!])
    end

    def get_points_by_line
      queue = cad_input_queue
      queue.show_command("Get points by line")
      start_point = queue.get_point
      if start_point.failure?
        return Failure(:point1_reset)
      end
      queue.send_command "PLACE LINE"
      queue.send_data_point start_point.value!
      end_point = queue.get_point("Enter next vertex")
      if end_point.failure?
        return Failure(:point2_reset)
      end
      Success([start_point.value!, end_point.value!])
    end

    def clear_ui
      cad_input_queue.clear_ui
    end

    def get_point
      cad_input_queue.get_point
    end


  end


  class App
    include Functions
  end
end

