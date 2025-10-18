class RecurringBadgeComponent < ViewComponent::Base
  def initialize(expense:)
    @expense = expense
  end

  def render?
    @expense.recurring?
  end

  def frequency_label
    @expense.recurrence_frequency&.capitalize
  end
end
