require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @expense = expenses(:one)
    sign_in @user
  end

  test "should get index" do
    get expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_url
    assert_response :success
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: { expense: { amount: @expense.amount, category: @expense.category, description: @expense.description, expense_date: @expense.expense_date, expense_type: @expense.expense_type, notes: @expense.notes, vendor: @expense.vendor } }
    end

    assert_redirected_to expense_url(Expense.last)
  end

  test "should show expense" do
    get expense_url(@expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_url(@expense)
    assert_response :success
  end

  test "should update expense" do
    patch expense_url(@expense), params: { expense: { amount: @expense.amount, category: @expense.category, description: @expense.description, expense_date: @expense.expense_date, expense_type: @expense.expense_type, notes: @expense.notes, vendor: @expense.vendor } }
    @expense.reload
    assert_redirected_to expense_url(@expense)
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete expense_url(@expense)
    end

    assert_redirected_to expenses_url
  end

  test "should create expense with receipt attachments" do
    file1 = fixture_file_upload("receipt1.pdf", "application/pdf")
    file2 = fixture_file_upload("receipt2.jpg", "image/jpeg")

    assert_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          amount: 100.50,
          description: "Test expense",
          expense_date: Date.today,
          expense_type: "business",
          category: "Office",
          vendor: "Test Vendor",
          receipts: [ file1, file2 ]
        }
      }
    end

    expense = Expense.last
    assert_equal 2, expense.receipts.count
    assert_redirected_to expense_url(expense)
  end

  test "should update expense and add receipt attachments" do
    file = fixture_file_upload("receipt1.pdf", "application/pdf")

    patch expense_url(@expense), params: {
      expense: {
        amount: @expense.amount,
        receipts: [ file ]
      }
    }

    @expense.reload
    assert_equal 1, @expense.receipts.count
    assert_redirected_to expense_url(@expense)
  end

  test "should create recurring expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          amount: 5000,
          description: "Office Rent",
          expense_date: Date.today,
          expense_type: "business",
          category: "Office",
          is_recurring: true,
          recurrence_frequency: "monthly",
          recurrence_start_date: Date.today
        }
      }
    end

    expense = Expense.last
    assert expense.recurring?
    assert_equal "monthly", expense.recurrence_frequency
    assert_redirected_to expense_url(expense)
  end

  test "should update expense to make it recurring" do
    patch expense_url(@expense), params: {
      expense: {
        is_recurring: true,
        recurrence_frequency: "weekly",
        recurrence_start_date: Date.today
      }
    }

    @expense.reload
    assert @expense.recurring?
    assert_equal "weekly", @expense.recurrence_frequency
    assert_redirected_to expense_url(@expense)
  end
end
