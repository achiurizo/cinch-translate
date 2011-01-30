# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cinch/plugins/translate/version"

Gem::Specification.new do |s|
  s.name        = "cinch-translate"
  s.version     = Cinch::Translate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Arthur Chiu"]
  s.email       = ["mr.arthur.chiu@gmail.com"]
  s.homepage    = "http://arthurchiu.tumblr.com"
  s.summary     = %q{Cinch Bot translation plugin}
  s.description = %q{Cinch Bot translation plugin powered by Google Translate}

  s.rubyforge_project = "cinch-translate"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency 'cinch', '~>1.1.1'
  s.add_dependency 'to_lang'
  s.add_development_dependency 'riot',  '~>0.12.0'
  s.add_development_dependency 'mocha', '~>0.9.10'
end
