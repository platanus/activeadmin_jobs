require "rails_helper"

describe "Job index", type: :feature do
  context "index view" do
    before { @admin = login_admin_user }

    context "with job without result" do
      before do
        @job = create_job(identifier: @admin.job_identifier, result: nil, notified: false)
        visit admin_job_path(@job)
      end

      it "shows id row" do
        row = find_row(:id, nil)
        expect(row.text).to eq(@job.id.to_s)
      end

      it "shows status row" do
        row = find_row(:status)
        expect(row[:class]).to eq("status_tag pending")
        expect(row.text).to eq("Pending")
      end

      it "shows created at row" do
        col = find_row(:created_at, nil)
        expect(col.text).to eq(I18n.l(@job.created_at, format: :long))
      end

      it "hides result panel" do
        expect { find_panel("Result") }.to raise_error(Capybara::ElementNotFound)
      end
    end

    context "with job with result" do
      before { @job = create_job(identifier: @admin.job_identifier, result: "result") }

      context "with finished status" do
        before do
          @job.update_column(:status, "finished")
          visit admin_job_path(@job)
          @panel = find_panel("Result", true)
        end

        it "renders finished view" do
          expect(@panel.text).to eq("Finished result")
        end
      end

      context "with failed status" do
        before do
          @job.update_column(:status, "failed")
          visit admin_job_path(@job)
          @panel = find_panel("Result", true)
        end

        it "renders failed view" do
          expect(@panel.text).to eq("Failed result")
        end
      end
    end
  end
end
