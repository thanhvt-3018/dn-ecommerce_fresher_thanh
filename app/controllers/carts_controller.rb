class CartsController < ApplicationController
  before_action :load_products_into_cart, :total_price_into_cart, only: :show

  def show; end

  def create
    product_id = params.dig(:session, :product_id)
    @cart.key?(product_id) ? @cart[product_id] += 1 : @cart[product_id] = 1
    flash[:success] = t "global.success.add_cart"
    redirect_to request.referer || root_path
  end

  def edit; end

  def destroy; end
end
