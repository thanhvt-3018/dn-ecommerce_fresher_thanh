class CheckoutsController < ApplicationController
  before_action :load_products_into_cart, :require_login, :total_price_into_cart, only: :show

  def show; end
end
