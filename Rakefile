# -*- ruby -*-

require "rubygems"
require "rake/clean"
require "standard/rake"
# require 'rake/testtask'
require "hoe"
# require 'hoe/minitest'
require "minitest"
require "minitest/test_task"
# require 'hoe/git'

class Hoe
  def intuit_values(input)
  end
end

# require 'rake/testtask'

CLEAN.include("**/#*.*#")
Hoe.plugin :bundler
# Hoe.plugin :minitest
Hoe.plugin :git
Hoe.plugin :yard
# Hoe.plugin :rubyforge
Hoe.spec "microstation" do
  self.summary = "A ruby gem to control and automate Bentley Microstation using win32ole"
  self.description = "Wrapping of microstation using win32ole to automate and control from ruby"
  developer("Dominic Sisneros", "dsisnero@gmail.com")
  clean_globs << "**/#*.*#"
  #  self.yard_markup = 'asciidoc'
  self.urls = {home: "https://github.com/dsisnero/microstation"}
  dependency("optparse-plus", ">= 0.0.0")
  dependency("liquid", "> 0.0.0")
  dependency("gli", "> 0.0.0")
  dependency("dry-monads", "> 0.0.0")
  # dependency('pry-nav', '>0.0.0',:dev)

  dependency("minitest", ">0.0.0", :dev)
  dependency("minitest-hooks", ">0.0", :dev)
  dependency("aruba", ">0.0.0", :dev)
  dependency("yard", ">= 0.0", :dev)
  dependency("hoe-yard", "~> 0.1", :dev)
  dependency("guard-yard", ">= 0.0", :dev)
  dependency("hoe", "~> 4", :dev)
  dependency("hoe-bundler", "> 0.0.0", :dev)
  dependency("guard", "> 0.0.0", :dev)
  dependency("guard-minitest", "> 0.0.0", :dev)
  dependency("minitest-focus", "> 0.0.0", :dev)
  dependency("notiffany", "> 0.0.0", :dev)
  dependency("aruba", "> 0.0.0", :dev)
  dependency("debug", "> 0.0.0", :dev)
  dependency("rb-readline", ">0.0.0", :dev)
  dependency("win32console", ">0.0.0", :dev)
  dependency("rb-notifu", "> 0.0.0", :dev)
  dependency("wdm", "> 0.0.0", :dev)
  dependency("solargraph", "> 0.0.0", :dev)
  dependency("standard", "> 0.0.0", :dev)
  dependency("solargraph-standardrb", "> 0.0.0", :dev)
  # dependency('windows-pr', '>0.0.0')
  license("MIT")
  #  require "debug";binding.break

  # self.rubyforge_name = 'microstation' # if different than 'microstation'
end



# vim: syntax=ruby
Minitest::TestTask.create("test2") do |t|
  t.libs.push("specs")
  t.test_globs = "spec/**/*_spec.rb"
end
