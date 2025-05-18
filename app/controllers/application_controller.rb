class ApplicationController < ActionController::Base
  before_action :set_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def next_locale
    locales = I18n.available_locales
    index = locales.index(I18n.locale)
    locales[(index + 1) % locales.size]
  end
  helper_method :next_locale

  private

  def extract_locale
    if params[:locale].present? && I18n.available_locales.include?(params[:locale].to_sym)
      cookies[:locale] = params[:locale]
    end

    cookies[:locale]&.to_sym if I18n.available_locales.include?(cookies[:locale]&.to_sym)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
