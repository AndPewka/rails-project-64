# frozen_string_literal: true

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale
  allow_browser versions: :modern

  def set_locale
    I18n.locale =
      params[:locale].presence_in(I18n.available_locales.map(&:to_s)) ||
      cookies[:locale] ||
      I18n.default_locale

    cookies[:locale] = I18n.locale
  end

  def default_url_options
    {}
  end
end
