# frozen_string_literal: true

class ExpenseCardComponent < ViewComponent::Base
  def initialize(expense:)
    @expense = expense
  end

  private

  attr_reader :expense

  def formatted_amount
    "¥#{number_with_delimiter(expense.amount.to_i)}"
  end

  def formatted_date
    expense.expense_date.strftime("%m/%d")
  end

  def category_display
    expense.category.presence || "Uncategorized"
  end

  def vendor_display
    expense.vendor.presence || "-"
  end
end
