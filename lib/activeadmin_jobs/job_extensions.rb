module ActiveadminJobs
  module JobExtensions
    def description
      I18n.t!("activeadmin_jobs.#{job_class.tableize.singularize}.description")
    rescue I18n::MissingTranslationData
      ""
    end
  end
end

JobNotifier::Job.send(:include, ActiveadminJobs::JobExtensions)
