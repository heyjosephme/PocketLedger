require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  test "can attach receipt files" do
    expense = expenses(:one)

    assert_respond_to expense, :receipts
  end

  test "can attach multiple receipt files" do
    expense = expenses(:one)

    file1 = fixture_file_upload("receipt1.pdf", "application/pdf")
    file2 = fixture_file_upload("receipt2.jpg", "image/jpeg")

    expense.receipts.attach(file1)
    expense.receipts.attach(file2)

    assert_equal 2, expense.receipts.count
  end

  test "can check if expense has attached receipts" do
    expense = expenses(:one)

    assert_not expense.receipts.attached?

    file = fixture_file_upload("receipt1.pdf", "application/pdf")
    expense.receipts.attach(file)

    assert expense.receipts.attached?
  end

  # Recurring expense tests
  test "expense is not recurring by default" do
    expense = Expense.new(
      user: users(:one),
      amount: 100,
      expense_date: Date.today,
      expense_type: :business
    )

    assert_not expense.recurring?
  end

  test "can create recurring expense" do
    expense = Expense.create!(
      user: users(:one),
      amount: 5000,
      description: "Office Rent",
      expense_date: Date.today,
      expense_type: :business,
      is_recurring: true,
      recurrence_frequency: "monthly",
      recurrence_start_date: Date.today
    )

    assert expense.recurring?
    assert_equal "monthly", expense.recurrence_frequency
    assert_nil expense.recurrence_end_date
  end

  test "recurring expense requires frequency when recurring" do
    expense = Expense.new(
      user: users(:one),
      amount: 5000,
      expense_date: Date.today,
      expense_type: :business,
      is_recurring: true,
      recurrence_start_date: Date.today
    )

    assert_not expense.valid?
    assert_includes expense.errors[:recurrence_frequency], "must be selected for recurring expenses"
  end

  test "recurring expense requires start date when recurring" do
    expense = Expense.new(
      user: users(:one),
      amount: 5000,
      expense_date: Date.today,
      expense_type: :business,
      is_recurring: true,
      recurrence_frequency: "monthly"
    )

    assert_not expense.valid?
    assert_includes expense.errors[:recurrence_start_date], "must be set for recurring expenses"
  end

  test "can have parent and child expenses" do
    parent = Expense.create!(
      user: users(:one),
      amount: 5000,
      expense_date: Date.today,
      expense_type: :business,
      is_recurring: true,
      recurrence_frequency: "monthly",
      recurrence_start_date: Date.today
    )

    child = Expense.create!(
      user: users(:one),
      amount: 5000,
      expense_date: Date.today + 1.month,
      expense_type: :business,
      parent_expense_id: parent.id
    )

    assert_equal parent, child.parent_expense
    assert_includes parent.child_expenses, child
  end

  test "calculates next occurrence date for monthly" do
    expense = Expense.new(
      recurrence_frequency: "monthly",
      recurrence_start_date: Date.new(2025, 1, 15)
    )

    assert_equal Date.new(2025, 2, 15), expense.next_occurrence_date(from: Date.new(2025, 1, 15))
    assert_equal Date.new(2025, 3, 15), expense.next_occurrence_date(from: Date.new(2025, 2, 15))
  end

  test "calculates next occurrence date for weekly" do
    expense = Expense.new(
      recurrence_frequency: "weekly",
      recurrence_start_date: Date.new(2025, 1, 6)
    )

    assert_equal Date.new(2025, 1, 13), expense.next_occurrence_date(from: Date.new(2025, 1, 6))
  end

  test "calculates next occurrence date for daily" do
    expense = Expense.new(
      recurrence_frequency: "daily",
      recurrence_start_date: Date.new(2025, 1, 1)
    )

    assert_equal Date.new(2025, 1, 2), expense.next_occurrence_date(from: Date.new(2025, 1, 1))
  end

  test "calculates next occurrence date for yearly" do
    expense = Expense.new(
      recurrence_frequency: "yearly",
      recurrence_start_date: Date.new(2025, 1, 1)
    )

    assert_equal Date.new(2026, 1, 1), expense.next_occurrence_date(from: Date.new(2025, 1, 1))
  end

  test "should generate next expense" do
    expense = Expense.create!(
      user: users(:one),
      amount: 5000,
      description: "Office Rent",
      expense_date: Date.today,
      expense_type: :business,
      category: "Office",
      vendor: "Landlord",
      is_recurring: true,
      recurrence_frequency: "monthly",
      recurrence_start_date: Date.today
    )

    next_expense = expense.generate_next_occurrence!

    assert next_expense.persisted?
    assert_equal expense.amount, next_expense.amount
    assert_equal expense.description, next_expense.description
    assert_equal expense.category, next_expense.category
    assert_equal expense.vendor, next_expense.vendor
    assert_equal expense.id, next_expense.parent_expense_id
    assert_not next_expense.recurring?
    assert_equal Date.today + 1.month, next_expense.expense_date
  end
end
