require "test_helper"

class RackAttackTest < ActionDispatch::IntegrationTest
  test "Rack::Attack middleware should be loaded" do
    assert Rails.application.config.middleware.include?(Rack::Attack),
           "Rack::Attack middleware should be configured"
  end

  test "Rack::Attack should have throttles configured" do
    # Check that throttles are defined
    assert Rack::Attack.throttles.key?("logins/ip"), "Should have login IP throttle"
    assert Rack::Attack.throttles.key?("logins/email"), "Should have login email throttle"
    assert Rack::Attack.throttles.key?("registrations/ip"), "Should have registration IP throttle"
    assert Rack::Attack.throttles.key?("req/ip"), "Should have general request throttle"
  end
end
