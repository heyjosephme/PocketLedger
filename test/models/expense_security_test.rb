require "test_helper"

class ExpenseSecurityTest < ActiveSupport::TestCase
  test "expense without receipts should be valid" do
    expense = Expense.new(
      user: users(:one),
      amount: 100.00,
      expense_date: Date.today,
      expense_type: :personal
    )

    assert expense.valid?, "Expense without receipts should be valid"
  end

  test "expense model should have file upload validation configured" do
    # Verify that the validation callback is registered
    callbacks = Expense._validate_callbacks.select { |cb| cb.filter == :acceptable_receipt_files }
    assert callbacks.any?, "Should have acceptable_receipt_files validation callback"
  end
end
