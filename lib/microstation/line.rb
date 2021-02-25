require 'microstation/element'

module Microstation

  class Line < Element

    def length
      ole_obj.Length
    end


    def vertices
      ole_obj.AsVertexList
      n = ole_obj.VerticesCount
      list = ole_obj.GetVertices
      list
    end
  end
end
