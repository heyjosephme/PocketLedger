class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    # Priority: 1. URL param, 2. Session, 3. Browser, 4. Default
    I18n.locale = params[:locale] ||
                  session[:locale] ||
                  extract_locale_from_accept_language_header ||
                  I18n.default_locale

    # Store locale in session for future requests
    session[:locale] = I18n.locale
  end

  def extract_locale_from_accept_language_header
    return nil unless request.env["HTTP_ACCEPT_LANGUAGE"]

    # Parse Accept-Language header and find first matching available locale
    request.env["HTTP_ACCEPT_LANGUAGE"].scan(/^[a-z]{2}/).first&.to_sym.tap do |locale|
      return locale if I18n.available_locales.include?(locale)
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
