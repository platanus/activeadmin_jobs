engine_path = File.join(File.dirname(__FILE__), '../')
# Require admin pages from dummy app
Dir[File.join(engine_path, "spec/dummy/app/admin/*.rb")].each { |f| require f }

module ActiveAdminHelpers
  def login_admin_user
    admin_user = AdminUser.create!(email: "admin@example.com", password: 12345678)
    login_as(admin_user, scope: :admin_user)
    admin_user
  end

  def logout_admin_user
    logout(:admin_user)
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.reload_routes! # To generate routes for /app/admin and /spec/dummy/app/admin.
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end

  config.include Warden::Test::Helpers
  config.include ActiveAdminHelpers
end
