require "application_system_test_case"

class RoutingTest < ApplicationSystemTestCase
  test "unauthenticated user visits root and sees landing page" do
    visit root_url

    # Should see landing page content
    assert_selector "h1", text: /Stop losing receipts/i
    assert_link "Start Free", href: new_user_registration_path
    assert_link "Sign In", href: new_user_session_path
  end

  test "authenticated user visits root and is redirected to expenses dashboard" do
    sign_in users(:one)

    visit root_url

    # Should be redirected to expenses page (dashboard)
    assert_current_path expenses_path
    assert_selector "h1", text: "Expenses"
  end

  test "authenticated user accessing /pages/home is also redirected to dashboard" do
    sign_in users(:one)

    visit pages_home_url

    # Should be redirected to expenses page (dashboard)
    assert_current_path expenses_path
    assert_selector "h1", text: "Expenses"
  end
end
