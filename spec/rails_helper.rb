require 'simplecov'
require 'coveralls'

formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter::new(formatters)

SimpleCov.start do
  add_filter do |src|
    r = [
      src.filename =~ /admin/,
      src.filename =~ /lib/,
      src.filename =~ /models/,
      src.filename =~ /controllers/
    ].uniq
    r.count == 1 && r.first.nil?
  end

  add_filter "engine.rb"
  add_filter "spec.rb"
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../dummy/config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"

engine_path = File.join(File.dirname(__FILE__), '../')
Dir[File.join(engine_path, "spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.filter_run_excluding skip: true
  config.run_all_when_everything_filtered = true
end
