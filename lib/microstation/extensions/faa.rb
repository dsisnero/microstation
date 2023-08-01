module Microstation
  class Drawing
    class Number
    end
  end
end

module Microstation
  class Drawing
    def number
      binding.break
      Drawing::Number.from_string(basename)
    end

    class Number
      DRAWING_RE = /(.+)-.+-(.+)-(.+).dgn/

      def self.from_string(drawing_name)
        md = DRAWING_RE.match(drawing_name.to_s)
        new(md[1], md[2], md[3])
      end

      def Index(str)
        return str if str == Drawing::Index
        Drawing::Index.new(str.to_s)
      end



      attr_reader :locid, :factype, :index

      def initialize(locid, factype, index)
        @locid = locid.to_s.upcase
        @factype = factype.to_s.upcase
        @index = Index(index)
      end

      def to_s
        [locid, "D", factype, index.to_s].join("-")
      end

      def discipline
        index.discipline
      end

      def +(other)
        self.class.new(locid, factype, index.+(other))
      end

      def -(other)
        self.class.new(locid, factype, index.-(other))
      end
    end

    class Index
      def initialize(str)
        return str if str === Index
        @nbr = str
      end

      def discipline
        @nbr[0].upcase
      end

      def digits
        @nbr[1..-1]
      end

      def to_s
        combined_string(digits_string)
      end

      def as_int
        digits.to_i
      end

      def digits_string(n = digits)
        "%03d" % n
      end

      def combined_string(dstring)
        "#{discipline}#{dstring}"
      end

      def +(other)
        self.class.new(combined_string(digits_string(as_int + other)))
      end

      def -(other)
        self.class.new(combined_string(digits_string(as_int - other)))
      end

      def succ
        self.+(1)
      end

      def pred
        self.-(1)
      end
    end
  end
end
