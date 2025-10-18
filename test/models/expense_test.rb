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
end
