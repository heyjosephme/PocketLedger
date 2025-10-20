require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "generates slug on create from email" do
    user = User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    assert_not_nil user.slug
    assert_equal "test-example-com", user.slug
  end

  test "can find user by slug" do
    user = User.create!(
      email: "findme@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    found_user = User.find(user.slug)
    assert_equal user.id, found_user.id
  end

  test "regenerates slug when email changes" do
    user = User.create!(
      email: "original@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    original_slug = user.slug

    user.update!(email: "updated@example.com")

    assert_not_equal original_slug, user.slug
    assert_equal "updated-example-com", user.slug
  end
end
