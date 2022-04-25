class OrdersController < ApplicationController
  before_action :require_login, :load_products_into_cart
  before_action :build_order, only: :create
  before_action :total_price_into_cart,
                :build_order_detail, only: :create
  before_action :load_orders, only: :index
  before_action :find_order, :update_quantity, only: :destroy

  def index; end

  def create
    @order.subtotal = @sum
    ActiveRecord::Base.transaction do
      @order.save!
    end
    session[:cart] = {}
    flash[:success] = t "global.success.order"
    redirect_to root_path
  rescue ActiveRecord::RecordNotSaved
    flash[:danger] = t "global.danger.order"
    redirect_to root_path
  end

  def destroy
    redirect_to orders_path
  end

  private

  def build_order
    @order = current_user.orders.build order_params
  end

  def order_params
    params.require(:order).permit :name, :phone, :address
  end

  def build_order_detail
    @products.each do |item|
      product_id = item.id.to_s
      quantity = @cart[product_id]
      price = item.price
      @order.order_details.build(product_id: product_id, quantity: quantity,
        price: price)
    end
  end

  def load_orders
    @orders = current_user.orders.newest
  end
end
