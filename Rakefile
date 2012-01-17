# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/git'

require 'rake/testtask'


# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
Hoe.plugin :minitest
Hoe.plugin :git
# Hoe.plugin :minitest
# Hoe.plugin :racc
# Hoe.plugin :rubyforge

Hoe.spec 'microstation' do
  # HEY! If you fill these out in ~/.hoe_template/Rakefile.erb then
  # you'll never have to touch them again!
  # (delete this comment too, of course)

  developer('Dominic Sisneros', 'dsisnero@gmail.com')

  # self.rubyforge_name = 'microstationx' # if different than 'microstation'
end

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end


# vim: syntax=ruby
