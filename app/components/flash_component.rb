# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(type:, message:)
    @type = type
    @message = message
  end

  private

  attr_reader :type, :message

  def icon_name
    case type.to_s
    when "notice"
      "info"
    when "success"
      "check-circle"
    when "alert"
      "alert-triangle"
    when "error"
      "x-circle"
    else
      "info"
    end
  end

  def container_classes
    base_classes = "fixed top-4 right-4 z-50 max-w-md w-full shadow-lg rounded-xl p-4 flex items-start gap-3 animate-slide-in"

    color_classes = case type.to_s
    when "notice"
      "bg-gradient-to-r from-blue-600 to-cyan-500 text-white"
    when "success"
      "bg-gradient-to-r from-green-600 to-emerald-500 text-white"
    when "alert"
      "bg-gradient-to-r from-amber-500 to-orange-500 text-white"
    when "error"
      "bg-gradient-to-r from-red-600 to-rose-500 text-white"
    else
      "bg-gradient-to-r from-blue-600 to-cyan-500 text-white"
    end

    "#{base_classes} #{color_classes}"
  end

  def icon_classes
    "w-6 h-6 flex-shrink-0"
  end
end
