ActiveAdmin.register JobNotifier::Job, as: "Job" do
  actions :index, :show

  filter :status
  filter :created_at

  controller do
    def scoped_collection
      user = send(ActiveAdmin.application.current_user_method)
      JobNotifier::Job.where(identifier: user.job_identifier)
    end
  end

  index do
    id_column
    tag_column :status
    column :description
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      tag_row :status
      row :description
      row :created_at
    end

    if !resource.result.blank?
      panel JobNotifier::Job.human_attribute_name(:result) do
        ActiveadminJobs::JobResultRenderer.new(self).render
      end
    end
  end
end
