module ActiveadminJobs
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminJobs

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end

    initializer "initialize" do
      require_relative "./activeadmin_config"
    end
  end
end
