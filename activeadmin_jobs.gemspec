$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin_jobs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmin_jobs"
  s.version     = ActiveadminJobs::VERSION
  s.authors     = ["Platanus", "Emilio Blanco", "Leandro Segovia"]
  s.email       = ["rubygems@platan.us", "emilioeduardob@gmail.com", "ldlsegovia@gmail.com"]
  s.homepage    = "https://github.com/platanus/activeadmin_jobs"
  s.summary     = "Gem that allows you to play nice with Active Job in Active Admin providing feedback"
  s.description = "It's a Rails engine that allows you to play nice with Active Job in Active Admin providing user feedback"
  s.license     = "MIT"

  s.files = `git ls-files`.split($/).reject { |fn| fn.start_with? "spec" }

  s.add_dependency "rails", "~> 4.2", ">= 4.2.0"
  s.add_dependency "job_notifier", "~> 1.1", ">= 1.1.1"
  s.add_dependency "devise", "~> 3.5", ">= 3.5.0"
  s.add_dependency "activeadmin", "~> 1.0.0.pre2"
  s.add_dependency "activeadmin_addons", "~> 0.9", ">= 0.9.2"

  s.add_development_dependency "pry-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.4.0"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "daemons"
  s.add_development_dependency "delayed_job_active_record"
  s.add_development_dependency "quiet_assets"
  s.add_development_dependency "jquery-ui-rails", "~> 5.0.5"
  s.add_development_dependency "coveralls"
end
