require "application_system_test_case"

class ConsecutiveEntryToggleTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
  end

  test "checkbox toggle changes submit button behavior" do
    visit new_expense_path

    # Initially, Quick Entry Mode checkbox should be unchecked
    assert_not find_field("Quick Entry Mode").checked?

    # Submit button should say "Save Expense"
    assert_button "Save Expense"

    # Check the Quick Entry Mode checkbox
    check "Quick Entry Mode"

    # Submit button should change to "Save & Add Another"
    assert_button "Save & Add Another"

    # Uncheck the checkbox
    uncheck "Quick Entry Mode"

    # Submit button should go back to "Save Expense"
    assert_button "Save Expense"
  end

  test "with quick entry mode enabled, creates consecutive expenses" do
    visit new_expense_path

    # Enable Quick Entry Mode
    check "Quick Entry Mode"

    # Fill in first expense
    fill_in "Amount", with: 1500
    fill_in "Expense date", with: "2025-01-15"
    select "Business", from: "Expense type"
    fill_in "Category", with: "Food"

    # Submit with Quick Entry Mode enabled
    click_button "Save & Add Another"

    # Should stay on new expense form
    assert_current_path new_expense_path

    # Common fields should be pre-filled
    assert_field "Category", with: "Food"

    # Checkbox should still be checked
    assert find_field("Quick Entry Mode").checked?

    # Should show success message
    assert_text "Expense created! Add another or view all expenses."
  end

  test "with quick entry mode disabled, redirects to expense detail" do
    visit new_expense_path

    # Leave Quick Entry Mode unchecked (default)
    assert_not find_field("Quick Entry Mode").checked?

    # Fill in expense
    fill_in "Amount", with: 1000
    fill_in "Expense date", with: "2025-01-15"
    select "Personal", from: "Expense type"

    # Submit normally
    click_button "Save Expense"

    # Should redirect to show page (not new form)
    assert_text "Expense was successfully created"
    assert_no_current_path new_expense_path
  end

  test "finish link is shown during consecutive entry" do
    visit new_expense_path

    # Initially, no finish link (Quick Entry Mode unchecked)
    assert_no_link "Finish & View All"

    # Enable Quick Entry Mode
    check "Quick Entry Mode"

    # Fill and submit first expense
    fill_in "Amount", with: 1000
    fill_in "Expense date", with: "2025-01-15"
    select "Business", from: "Expense type"
    click_button "Save & Add Another"

    # Should be on new form with finish link visible
    assert_current_path new_expense_path
    assert_link "Finish & View All"

    # Clicking finish link should go to expenses index
    click_link "Finish & View All"
    assert_current_path expenses_path
    assert_text "Dashboard"
  end
end
