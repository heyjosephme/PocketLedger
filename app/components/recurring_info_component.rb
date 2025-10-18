class RecurringInfoComponent < ViewComponent::Base
  def initialize(expense:)
    @expense = expense
  end

  def render?
    @expense.recurring?
  end

  def frequency_text
    case @expense.recurrence_frequency
    when "daily" then "Every day"
    when "weekly" then "Every week"
    when "monthly" then "Every month"
    when "yearly" then "Every year"
    end
  end

  def status_text
    if @expense.recurrence_end_date.present? && @expense.recurrence_end_date < Date.current
      "Ended"
    elsif @expense.recurrence_end_date.present?
      "Ends #{@expense.recurrence_end_date.strftime('%b %d, %Y')}"
    else
      "Ongoing"
    end
  end

  def status_color
    if @expense.recurrence_end_date.present? && @expense.recurrence_end_date < Date.current
      "text-red-600"
    else
      "text-green-600"
    end
  end

  def next_date
    @expense.next_occurrence_date(from: @expense.recurrence_start_date)
  end

  def child_count
    @expense.child_expenses.count
  end
end
