# frozen_string_literal: true

class ExpenseTypeBadgeComponent < ViewComponent::Base
  def initialize(expense_type:)
    @expense_type = expense_type.to_s
  end

  private

  attr_reader :expense_type

  def badge_classes
    "inline-flex items-center gap-1 px-3 py-1 rounded-xl text-xs font-semibold bg-gray-100 text-gray-700 border border-gray-200"
  end

  def badge_icon
    case expense_type
    when "business"
      # Briefcase icon
      '<svg class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
      </svg>'.html_safe
    when "personal"
      # User icon
      '<svg class="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
      </svg>'.html_safe
    else
      ""
    end
  end

  def badge_text
    expense_type.capitalize
  end
end
