require "rails_helper"

describe "Job index", type: :feature do
  context "index view" do
    before do
      login_admin_user
      @job = create_job(notified: false)
      visit admin_jobs_path
    end

    it "shows jobs table" do
      expect(page).to have_content "Displaying 1 Job"
    end

    it "shows id column" do
      col = find_column(:id)
      expect(col.text).to eq(@job.id.to_s)
    end

    it "shows status column" do
      col = find_column(:status)
      expect(col[:class]).to eq("status_tag pending")
      expect(col.text).to eq("Pending")
    end

    it "shows created at column" do
      col = find_column(:created_at)
      expect(col.text).to eq(I18n.l(@job.created_at, format: :long))
    end
  end
end
