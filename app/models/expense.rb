class Expense < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: [ :slugged, :scoped, :finders ], scope: :user

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

  # File upload validations for security
  validate :acceptable_receipt_files

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

  # Generate slug candidates for friendly_id
  # Tries: date-description, date-amount-description, date-category, date-id
  def slug_candidates
    [
      [ :expense_date_formatted, :description_truncated ],
      [ :expense_date_formatted, :amount_formatted, :description_truncated ],
      [ :expense_date_formatted, :category ],
      [ :expense_date_formatted, :id ]
    ]
  end

  # Regenerate slug if description or date changes
  def should_generate_new_friendly_id?
    description_changed? || expense_date_changed? || slug.blank?
  end

  def expense_date_formatted
    expense_date&.strftime("%Y-%m-%d")
  end

  def amount_formatted
    amount&.to_i&.to_s
  end

  def description_truncated
    description&.truncate(40, omission: "", separator: " ")
  end

  private

  def acceptable_receipt_files
    return unless receipts.attached?

    receipts.each do |receipt|
      unless receipt.content_type.in?(%w[image/png image/jpeg image/jpg application/pdf])
        errors.add(:receipts, "must be a PNG, JPEG, or PDF file")
      end

      if receipt.byte_size > 10.megabytes
        errors.add(:receipts, "file size must be less than 10MB")
      end
    end

    if receipts.count > 5
      errors.add(:receipts, "cannot attach more than 5 files")
    end
  end
end
