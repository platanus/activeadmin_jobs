ActiveAdmin.register JobNotifier::Job, as: "Job" do
  actions :index, :show

  filter :status
  filter :notified
  filter :created_at

  index do
    id_column
    tag_column :status
    bool_column :notified
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      tag_row :status
      bool_row :notified
      row :created_at
    end

    panel JobNotifier::Job.human_attribute_name(:result) do
      ActiveadminJobs::JobResultRenderer.new(self).render
    end unless resource.result.blank?
  end
end
