require "test_helper"

class UserSecurityTest < ActiveSupport::TestCase
  test "user should be lockable after failed login attempts" do
    user = users(:one)

    # Devise lockable should be enabled
    assert User.devise_modules.include?(:lockable)
  end

  test "user should have lockable fields" do
    user = users(:one)

    assert_respond_to user, :failed_attempts
    assert_respond_to user, :unlock_token
    assert_respond_to user, :locked_at
  end

  test "failed_attempts should default to 0" do
    user = User.new(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert_equal 0, user.failed_attempts
  end
end
