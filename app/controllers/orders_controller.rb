class OrdersController < ApplicationController
  before_action :load_products_into_cart
  before_action :build_order, only: %i(new create)
  before_action :total_price_into_cart,
                :build_order_detail, only: :create

  def new; end

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
    render :new
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
end
