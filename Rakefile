# -*- ruby -*-

require 'rubygems'
require 'rake/clean'
require 'hoe'
#require 'hoe/git'

require 'rake/testtask'

CLEAN.include("**/#*.*#")
Hoe.plugin :bundler
Hoe.plugin :minitest
Hoe.plugin :git
# Hoe.plugin :rubyforge

Hoe.spec 'microstation' do
  developer('Dominic Sisneros', 'dsisnero@gmail.com')
  clean_globs << '**/#*.*#'
  dependency('rspec', '~> 3.2', :dev)
  dependency('hoe','> 0.0.0', :dev)
  dependency('hoe-bundler', '> 0.0.0', :dev)
  dependency('methadone','>= 0.0.0')
  dependency('liquid', '> 0.0.0')
  dependency('virtus', '> 0.0.0')
  dependency('pry', '> 0.0.0', :dev)
  # dependency('pry-nav', '>0.0.0',:dev)
  dependency('hash_maps','>0.0.0')
 # dependency('windows-pr', '>0.0.0')
  license('MIT')

  # self.rubyforge_name = 'microstation' # if different than 'microstation'
end



# vim: syntax=ruby
