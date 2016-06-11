module ActiveadminJobs
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminJobs

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end

    initializer "initialize" do
      require_relative "./i18n_dictionary"
      require_relative "./job_result_renderer"
      require_relative "./activeadmin_config"
    end
  end
end
