# -*- ruby -*-

require 'rubygems'
require 'rake/clean'
require 'hoe'
#require 'hoe/git'

require 'rake/testtask'

CLEAN.include("**/#*.*#")

# Hoe.plugin :compiler
# Hoe.plugin :gem_prelude_sucks
# Hoe.plugin :inline
Hoe.plugin :minitest
Hoe.plugin :git
# Hoe.plugin :minitest
# Hoe.plugin :racc
# Hoe.plugin :rubyforge

Hoe.spec 'microstation' do
  developer('Dominic Sisneros', 'dsisnero@gmail.com')
  clean_globs << '**/#*.*#'
  dependency('rspec', '> 0.0.0', :dev)
  dependency('methadone','>= 0.0.0')
  dependency('liquid', '> 0.0.0')
  dependency('virtus', '> 0.0.0')

  # self.rubyforge_name = 'microstation' # if different than 'microstation'
end



# vim: syntax=ruby
