require "application_system_test_case"

class LandingPageTest < ApplicationSystemTestCase
  test "visiting the landing page shows all key sections" do
    visit root_url

    # Hero section
    assert_selector "h1", text: /Stop losing receipts|saving on taxes/i
    assert_link "Start Free", href: new_user_registration_path
    assert_link "Sign In", href: new_user_session_path

    # Features section
    assert_text "Features that actually matter"
    assert_text "Receipt"
    assert_text "Recurring"

    # How It Works section
    assert_text "How It Works"

    # Social proof section
    assert_text "freelancers"

    # Final CTA
    assert_link "Get Started Free", href: new_user_registration_path
  end

  test "landing page has proper startup-style design elements" do
    visit root_url

    # Should have large headings
    assert_selector "h1.text-5xl, h1.text-6xl"

    # Should have rounded buttons
    assert_selector "a.rounded-xl, a.rounded-2xl"

    # Should have feature cards
    assert_selector "[class*='grid']"
  end
end
