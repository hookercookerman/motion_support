# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion_support/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["hookercookerman"]
  gem.email         = ["hookercookerman@gmail.com"]
  gem.description   = %q{A toolkit of support libraries and RubyMotion Core extensions}
  gem.summary       = %q{A toolkit of support libraries and RubyMotion Core extensions}
  gem.homepage      = "http://www.thehitchhikerprinciple"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "motion_support"
  gem.require_paths = ["lib"]
  gem.version       = MotionSupport::VERSION

  gem.add_dependency 'bubble-wrap'
end
