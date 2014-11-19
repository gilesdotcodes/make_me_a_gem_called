# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'make_me_a_gem_called/version'

Gem::Specification.new do |spec|
  spec.name          = "make_me_a_gem_called"
  spec.version       = MakeMeAGemCalled::VERSION
  spec.authors       = ["Stephen Giles"]
  spec.email         = [""]
  spec.summary       = "This a gem that creates everything you need to make a gem!"
  spec.description   = "Having followed a tutorial by Matt Huggins on quickleft.com, I have been building some basic gems. This gem is designed to quickly set up the folder and file structure I like to use. It uses bundler to create the first layer and then I add a few more things on top."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  # spec.add_runtime_dependency "bundler", "~> 1.7"
end
