# frozen_string_literal: true

class ExpenseTypeBadgeComponent < ViewComponent::Base
  def initialize(expense_type:)
    @expense_type = expense_type.to_s
  end

  private

  attr_reader :expense_type

  def badge_classes
    base_classes = "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
    
    case expense_type
    when "business"
      "#{base_classes} bg-green-100 text-green-800"
    when "personal" 
      "#{base_classes} bg-blue-100 text-blue-800"
    else
      "#{base_classes} bg-gray-100 text-gray-800"
    end
  end

  def badge_text
    expense_type.capitalize
  end
end
