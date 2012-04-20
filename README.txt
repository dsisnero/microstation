= microstation

http://github.com/dsisnero/microstation

== DESCRIPTION:

this is a gem that wraps Bentley Microstation using the WIN32OLE
library.

== FEATURES/PROBLEMS:



== SYNOPSIS:
  text_in_drawing = []
  Microstation.run do |app|
     sc = create_scanner do 
         include_color(3)
         include_level(3)
     end
     app.open_drawing('./test.dgn') do |drawing|
       drawing.scan_text do |text|
          text.reverse! if text =~ /Reverse/  # things that modify thetext_in_drawing 
          puts text.to_s
       end
       drawing.scan( sc) do |ele|
          
       end

       
       drawing.save_as_pdf
     end
  end

== REQUIREMENTS:

An installed version of Microstation

== INSTALL:

* sudo gem install microstation

== DEVELOPERS:

After checking out the source, run:

  $ rake 

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2012 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
