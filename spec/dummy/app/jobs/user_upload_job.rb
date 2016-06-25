class UserUploadJob < ActiveJob::Base
  def perform_with_feedback(result)
    sleep([*5..20].sample) # faking processing time
    return "Users loaded successfully" if result

    errors = [
      { row: 4, errors: ["Invalid First Name", "Invalid Category"] },
      { row: 6, errors: ["Invalid Last Name"] },
      { row: 84, errors: ["Invalid ID"] }
    ]

    raise JobNotifier::Error::Validation.new(errors)
  end
end
