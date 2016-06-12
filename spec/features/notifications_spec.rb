require "rails_helper"

describe "Notifications", type: :feature do
  before(:all) do
    # Give more time to notifications
    @old_default_max_wait_time = Capybara.default_max_wait_time
    Capybara.default_max_wait_time = 15
  end

  after(:all) do
    # Restore default
    Capybara.default_max_wait_time = @old_default_max_wait_time
  end

  before { @admin = login_admin_user }

  context "with one pending job" do
    before do
      create_job(identifier: @admin.job_identifier, notified: false, status: "pending")
      visit admin_jobs_path
    end

    it "shows pending notification", js: true do
      expect(notification_title.text).to eq("Pending Job")
      expect(notification_link.text).to eq("job added to the queue...")
      notification_link.click
      expect(find_row(:status).text).to eq("PENDING")
    end
  end

  context "with one finished job" do
    before do
      create_job(identifier: @admin.job_identifier, notified: false, status: "finished")
      visit admin_jobs_path
    end

    it "shows finished notification", js: true do
      expect(notification_title.text).to eq("Finished Job!")
      expect(notification_link.text).to eq("the job was completed! :)")
      notification_link.click
      expect(find_row(:status).text).to eq("FINISHED")
    end
  end

  context "with one failed job" do
    before do
      create_job(identifier: @admin.job_identifier, notified: false, status: "failed")
      visit admin_jobs_path
    end

    it "shows failed notification", js: true do
      expect(notification_title.text).to eq("Failed Job")
      expect(notification_link.text).to eq("the job was not completed :(")
      notification_link.click
      expect(find_row(:status).text).to eq("FAILED")
    end
  end

  context "with multiple jobs" do
    before do
      3.times { create_job(identifier: @admin.job_identifier, notified: false, status: "pending") }
      2.times { create_job(identifier: @admin.job_identifier, notified: false, status: "finished") }
      job = create_job(identifier: @admin.job_identifier, notified: false, status: "failed")
      visit admin_job_path(job)
    end

    it "shows multiple notifications", js: true do
      expect(notification_title(1).text).to eq("Pending Job")
      expect(notification_title(2).text).to eq("Finished Job!")
      expect(notification_title(3).text).to eq("Failed Job")

      expect(notification_link(1).text).to eq("3 jobs were added to the queue...")
      expect(notification_link(2).text).to eq("2 jobs were completed! :)")
      expect(notification_link(3).text).to eq("the job was not completed :(")

      notification_link(2).click
      expect(page).to have_content "Displaying all 6 Jobs"
    end
  end
end
