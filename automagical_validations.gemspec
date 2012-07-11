# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "automagical_validations"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Toms Mikoss"]
  s.date = "2012-07-11"
  s.description = "ActiveRecord extension that allows to infer validation rules from database"
  s.email = "toms.mikoss@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "automagical_validations.gemspec",
    "lib/automagical_validations.rb",
    "spec/automagical_validations_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/tmikoss/automagical_validations"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "ActiveRecord extension that allows to infer validation rules from database"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, [">= 0"])
      s.add_development_dependency(%q<activerecord-jdbcmysql-adapter>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<mysql2>, [">= 0"])
      s.add_dependency(%q<activerecord-jdbcmysql-adapter>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<mysql2>, [">= 0"])
    s.add_dependency(%q<activerecord-jdbcmysql-adapter>, [">= 0"])
  end
end

