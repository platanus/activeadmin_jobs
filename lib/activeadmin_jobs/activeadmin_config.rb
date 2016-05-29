ActiveAdmin.setup do |config|
  config.load_paths += [File.join(ActiveadminJobs::Engine.root, "app", "admin")]
end

class ActiveAdmin::Views::Pages::Base
  alias_method :original_add_classes_to_body, :add_classes_to_body

  def add_classes_to_body
    original_add_classes_to_body
    current_user_method = ActiveAdmin.application.current_user_method

    if current_user_method
      admins_job_identifier = send(current_user_method).job_identifier
      @body.set_attribute "data-identifier", admins_job_identifier
      @body.set_attribute "data-root-url", "/"
    end
  end
end
