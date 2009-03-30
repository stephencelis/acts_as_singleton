$: << File.dirname(__FILE__) + "/lib"
require "rubygems"
require "hoe"
require "active_record"
require "acts_as_singleton"

Hoe.new("acts_as_singleton", ActiveRecord::Singleton::VERSION) do |p|
  p.developer("Stephen Celis", "stephen@stephencelis.com")
end

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the acts_as_singleton plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the acts_as_singleton plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'acts_as_singleton'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
