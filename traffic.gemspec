# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "traffic/version"

Gem::Specification.new do |s|
  s.name        = "traffic"
  s.version     = Traffic::VERSION
  s.authors     = ["Craig Wickesser"]
  s.email       = ["craig@mindscratch.org"]
  s.homepage    = ""
  s.summary     = %q{Count severe traffic incidents in a given area.}
  s.description = s.summary

  s.rubyforge_project = "traffic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"

  s.add_dependency "typhoeus"
end
