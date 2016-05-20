Rails.application.routes.draw do
  mount JobNotifier::Engine => "/job_notifier"
  mount ActiveadminJobs::Engine => "/activeadmin_jobs"
end
