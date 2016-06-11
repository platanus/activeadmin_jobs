module ActiveadminJobs
  class JobResultRenderer
    attr_reader :page, :job, :result

    def initialize(page)
      @page = page
      @job = @page.resource
      @result = @job.result
    end

    def render
      page.render(partial: partial_path, locals: { job: job, result: formatted_result })
    end

    private

    def partial_path
      "#{job.job_class.tableize.singularize}.#{job.status}.html.erb"
    end

    def formatted_result
      eval(job.result)
    rescue Exception
      job.result
    end
  end
end
