class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper
  include Pagy::Backend
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  before_action :set_locale, :init_cart, :load_cart

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def redirect_to_last_page exception
    redirect_to url_for(page: exception.pagy.last)
  end
end
