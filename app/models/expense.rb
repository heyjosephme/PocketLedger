class Expense < ApplicationRecord
  belongs_to :user
  
  enum :expense_type, { personal: 0, business: 1 }
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_date, presence: true
  validates :expense_type, presence: true
end
