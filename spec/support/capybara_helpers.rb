module CapybaraHelpers
  def find_column(attribute, tag = nil)
    inner_tag = case attribute
                when :id then "a"
                when :created_at then nil
                else "span"
                end

    inner_tag = tag if tag
    col = find("td[class=\"col col-#{attribute}\"]")
    col = col.find(inner_tag) if inner_tag
    col
  end

  def find_row(attribute, tag = "span")
    row = find("tr[class=\"row row-#{attribute}\"]").find("td")
    row = row.find(tag) if tag
    row
  end

  def find_panel(title, content = false)
    panel = find("h3", text: title).find(:xpath, "..")
    return panel unless content
    panel.find("div[class=\"panel_contents\"]")
  end

  def create_job(identifier: nil, status: nil, result: nil, notified: nil)
    data = {
      identifier: identifier || SecureRandom.hex,
      job_id: 1,
      job_class: "JobExample",
      status: status || "pending",
      result: result,
      notified: notified.nil? ? [true, false].sample : notified
    }

    @job = JobNotifier::Job.create!(data)
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers
end
