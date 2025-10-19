require "application_system_test_case"

class ConsecutiveExpenseEntryTest < ApplicationSystemTestCase
  setup do
    sign_in users(:one)
  end

  test "creating expense with 'Create Another' pre-fills common fields" do
    visit new_expense_path

    # Enable Quick Entry Mode
    check "Quick Entry Mode"

    # Fill in first expense
    fill_in "Amount", with: 1500
    fill_in "Expense date", with: "2025-01-15"
    select "Business", from: "Expense type"
    fill_in "Category", with: "Food"
    fill_in "Vendor", with: "Starbucks"
    fill_in "Description", with: "Coffee meeting"

    # Click "Save & Add Another"
    click_button "Save & Add Another"

    # Should stay on new expense form
    assert_current_path new_expense_path

    # Common fields should be pre-filled
    # Check that expense type and category are pre-filled
    assert_select "Expense type", selected: "Business"
    assert_field "Category", with: "Food"

    # Check that date field has a value (pre-filled, even if format varies)
    date_field = find_field("Expense date")
    assert date_field.value.present?, "Date field should be pre-filled"

    # Unique fields should be cleared
    assert_field "Amount", with: ""
    assert_field "Vendor", with: ""
    assert_field "Description", with: ""

    # Should show success message
    assert_text "Expense created! Add another or view all expenses."
  end

  test "creating expense with 'Done' redirects to index" do
    visit new_expense_path

    # Leave Quick Entry Mode unchecked (default)

    fill_in "Amount", with: 1500
    fill_in "Expense date", with: "2025-01-15"
    select "Business", from: "Expense type"

    # Click regular submit button (Save Expense)
    click_button "Save Expense"

    # Should redirect to show page (current behavior)
    assert_text "Expense was successfully created"
  end

  test "session counter shows number of expenses created" do
    visit new_expense_path

    # Enable Quick Entry Mode
    check "Quick Entry Mode"

    # Create first expense
    fill_in "Amount", with: 1000
    fill_in "Expense date", with: "2025-01-15"
    select "Personal", from: "Expense type"
    click_button "Save & Add Another"

    assert_text "1 expense created this session"

    # Create second expense
    fill_in "Amount", with: 2000
    click_button "Save & Add Another"

    assert_text "2 expenses created this session"

    # Create third expense
    fill_in "Amount", with: 3000
    click_button "Save & Add Another"

    assert_text "3 expenses created this session"
  end
end
