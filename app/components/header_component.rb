# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end

  private

  attr_reader :current_user

  def signed_in?
    current_user.present?
  end
end