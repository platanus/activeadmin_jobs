ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  collection_action :import_form, title: "Import Users" do
  end

  action_item :import_users, only: :index do
    link_to "Import Users", import_form_admin_admin_users_path
  end

  collection_action :import, title: "Import Users", method: :post do
    JobExample.perform_later(current_admin_user.job_identifier, [true, false].sample)
    redirect_to import_form_admin_admin_users_path, notice: "The import process was started. We'll notify you when it's done."
  end
end
