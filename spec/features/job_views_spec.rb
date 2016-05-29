require "rails_helper"

describe "Job views", type: :feature do
  context "index view" do
    before { login_admin_user }

    it "shows jobs table" do
      JobNotifier::Job.create!
      visit admin_jobs_path
      expect(page).to have_content "Displaying 1 Job"
    end
  end
end
