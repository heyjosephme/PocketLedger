class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :parent_expense, class_name: "Expense", optional: true
  has_many :child_expenses, class_name: "Expense", foreign_key: :parent_expense_id, dependent: :nullify
  has_many_attached :receipts

  enum :expense_type, { personal: 0, business: 1 }

  # Explicitly declare attribute type for Rails 8 enum with string values
  attribute :recurrence_frequency, :string
  enum :recurrence_frequency, { daily: "daily", weekly: "weekly", monthly: "monthly", yearly: "yearly" }, prefix: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :expense_date, presence: true
  validates :expense_type, presence: true
  validates :recurrence_frequency, presence: { message: "must be selected for recurring expenses" }, if: :is_recurring
  validates :recurrence_start_date, presence: { message: "must be set for recurring expenses" }, if: :is_recurring

  scope :recurring, -> { where(is_recurring: true) }
  scope :non_recurring, -> { where(is_recurring: false) }
  scope :templates, -> { where(is_recurring: true) }

  def recurring?
    is_recurring
  end

  def next_occurrence_date(from: Date.current)
    return nil unless recurrence_frequency.present?

    case recurrence_frequency
    when "daily"
      from + 1.day
    when "weekly"
      from + 1.week
    when "monthly"
      from + 1.month
    when "yearly"
      from + 1.year
    end
  end

  def generate_next_occurrence!
    next_date = next_occurrence_date(from: recurrence_start_date)

    child_expenses.create!(
      user: user,
      amount: amount,
      description: description,
      expense_date: next_date,
      expense_type: expense_type,
      category: category,
      vendor: vendor,
      notes: notes,
      is_recurring: false
    )
  end
end
