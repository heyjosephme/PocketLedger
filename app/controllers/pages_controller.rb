class PagesController < ApplicationController
  def home
    # Redirect authenticated users to expenses dashboard
    redirect_to expenses_path if user_signed_in?
  end

  def privacy
  end

  def terms
  end

  def support
  end

  def about
  end
end
