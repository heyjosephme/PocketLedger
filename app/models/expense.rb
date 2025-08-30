class Expense < ApplicationRecord
  enum :expense_type, { personal: 0, business: 1 }
  # amount, integer or not?
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_date, presence: true
  validates :expense_type, presence: true
end
