require 'pathname'

class Pathname
  def ext(newext = '')
    str = to_s
    return dup if ['.', '..'].include? str

    if newext != ''
      newext = newext =~ /^\./ ? newext : ('.' + newext)
    end
    Pathname.new(str.dup.sub!(%r{([^/\\])\.[^./\\]*$}) { ::Regexp.last_match(1) + newext } || str + newext)
  end

  def extstr(newext = '')
    Pathname.new(to_s.ext(newext))
  end

  def glob(pattern)
    self.class.glob("#{self}/#{pattern}")
  end
end
