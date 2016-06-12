class JobExample < ActiveJob::Base
  def perform_with_feedback(result)
    sleep(20) # faking long process
    return "SUCCESS!!!" if result
    raise JobNotifier::Error::Validation.new("ERROR!!!")
  end
end
