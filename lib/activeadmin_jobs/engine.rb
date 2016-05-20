module ActiveadminJobs
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminJobs

    initializer "initialize" do
      require_relative "./activeadmin_config"
    end
  end
end
