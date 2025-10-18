class Expense < ApplicationRecord
  belongs_to :user
  has_many_attached :receipts

  enum :expense_type, { personal: 0, business: 1 }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_date, presence: true
  validates :expense_type, presence: true
end
