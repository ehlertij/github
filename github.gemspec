# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "github/version"

Gem::Specification.new do |s|
  s.name        = "github"
  s.version     = Github::VERSION
  s.authors     = ["Ian Ehlert","Jon Phenow"]
  s.email       = ["ian.ehlert@tstmedia.com","jon.phenow@tstmedia.com"]
  s.homepage    = ""
  s.summary     = %q{Github API connector}
  s.description = %q{}

  s.rubyforge_project = "github"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
