$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_jobs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_jobs"
  s.version     = ActiveadminJobs::VERSION
  s.authors     = ["Leandro Segovia"]
  s.email       = ["ldlsegovia@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveadminJobs."
  s.description = "TODO: Description of ActiveadminJobs."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5.2"

  s.add_development_dependency "sqlite3"
end
