require "application_system_test_case"

class StaticPagesTest < ApplicationSystemTestCase
  test "visiting the privacy policy page" do
    visit privacy_url
    assert_selector "h1", text: "Privacy Policy"
    assert_text "PocketLedger"
    assert_text "Data Collection"
  end

  test "visiting the terms of service page" do
    visit terms_url
    assert_selector "h1", text: "Terms of Service"
    assert_text "PocketLedger"
    assert_text "agreement"
  end

  test "visiting the support page" do
    visit support_url
    assert_selector "h1", text: "Support"
    assert_text "Contact Methods"
  end

  test "visiting the about page" do
    visit about_url
    assert_selector "h1", text: "About PocketLedger"
    assert_text "expense tracking"
  end

  test "footer links on home page" do
    visit root_url
    assert_link "Privacy Policy", href: privacy_path
    assert_link "Terms of Service", href: terms_path
    assert_link "Support", href: support_path
    assert_link "About", href: about_path
  end
end
