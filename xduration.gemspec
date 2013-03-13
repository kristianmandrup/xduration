# -*- encoding: utf-8 -*-
require File.expand_path("../lib/duration/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "xduration"
  s.version     = Duration::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jose Peleteiro", "Bruno Azisaka Maciel", "Kristian Mandrup"]
  s.email       = ["jose@peleteiro.net", "bruno@azisaka.com.br", "kmandrup@gmail.com"]
  s.homepage    = "http://github.com/kristianmandrup/xduration"
  s.summary     = "Duration type with Mongoid 2.4+ support"
  s.description = "Duration with support for longer time periods"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "activesupport", ">= 3.0.0"
  s.add_dependency "i18n",          ">= 0.6"

  s.add_development_dependency "bundler",   ">= 1.0.0"
  s.add_development_dependency "minitest",  ">= 0"
  s.add_development_dependency "yard",      ">= 0"
  s.add_development_dependency "rake",      ">= 0.9.2"
  s.add_development_dependency "simplecov", ">= 0.5"
  s.add_development_dependency "mongoid",   ">= 2.4.0"
  s.add_development_dependency "rails",     ">= 3.1"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.rdoc_options = ["--charset=UTF-8"]
end
