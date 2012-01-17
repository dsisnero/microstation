require 'pathname'

  
 class Pathname

   def ext(newext = '')
     str = self.to_s
    return self.dup if ['.', '..'].include? str
    if newext != ''
      newext = (newext =~ /^\./) ? newext : ("." + newext)
    end
    Pathname.new(str.dup.sub!(%r(([^/\\])\.[^./\\]*$)) { $1 + newext } || str + newext)
   end

  def extstr(newext='')
    Pathname.new( self.to_s.ext(newext))
  end

  
  def glob(pattern)
    self.class.glob("#{self.to_s}/#{pattern}")
  end
  

end
