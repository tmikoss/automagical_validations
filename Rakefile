# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "automagical_validations"
  gem.homepage = "http://github.com/tmikoss/automagical_validations"
  gem.license = "MIT"
  gem.summary = %Q{ActiveRecord extension that allows to infer validation rules from database}
  gem.description = %Q{ActiveRecord extension that allows to infer validation rules from database}
  gem.email = "toms.mikoss@gmail.com"
  gem.authors = ["Toms Mikoss"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Create database to run tests on'
task :create_database do
  `mysql -u root -e 'create database automagical_validations_test;'`
end

task :default => :spec
