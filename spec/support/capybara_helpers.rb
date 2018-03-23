require "capybara/rspec"
require "capybara/rails"
require "selenium-webdriver"

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

  def notification(pos = 1)
    find(".growl:nth-of-type(#{pos})")
  end

  def notification_title(pos = 1)
    notification(pos).find(".growl-title")
  end

  def notification_link(pos = 1)
    notification(pos).find(".growl-message").find("a")
  end

  def create_job(identifier: nil, status: nil, result: nil, notified: nil)
    data = {
      identifier: identifier || SecureRandom.hex,
      job_id: 1,
      job_class: "JobTest",
      status: status || "pending",
      result: result,
      notified: notified.nil? ? [true, false].sample : notified
    }

    @job = JobNotifier::Job.create!(data)
  end
end

RSpec.configure do |config|
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :headless_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless) }
    )
    Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
  end

  # change to :chrome if you want to see the browser running.
  Capybara.javascript_driver = :headless_chrome

  config.include CapybaraHelpers
end
