require 'microstation/element'

module Microstation
  class Line < Element
    def length
      ole_obj.Length
    end

    def vertices
      ole_obj.AsVertexList
      n = ole_obj.VerticesCount
      ole_obj.GetVertices
    end
  end
end
