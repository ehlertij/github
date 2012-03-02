# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "github_issues/version"

Gem::Specification.new do |s|
  s.name        = "github_issues"
  s.version     = GithubIssues::VERSION
  s.authors     = ["Jon Phenow"]
  s.email       = ["jon.phenow@tstmedia.com"]
  s.homepage    = ""
  s.summary     = %q{Github API connector}
  s.description = %q{}

  s.rubyforge_project = "github_issues"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
