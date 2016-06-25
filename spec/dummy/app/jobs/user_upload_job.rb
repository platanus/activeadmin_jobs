class UserUploadJob < ActiveJob::Base
  def perform_with_feedback(result)
    sleep([*5..20].sample) # faking processing time
    return "Users loaded successfully" if result
    raise JobNotifier::Error::Validation.new("ERROR!!!")
  end
end
