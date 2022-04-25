class Admin::OrdersController < AdminController
  before_action :find_order, only: %i(destroy update)
  before_action :update_quantity, only: :destroy

  def index
    @delivering_orders = Order.delivering
    @received_orders = Order.received
    @pending_orders = Order.pending
    @pagy, @orders = pagy(Order.newest, items: Settings.pagy_item_10)
  end

  def destroy
    redirect_to admin_orders_path
  end

  def update
    return if params[:order].nil?

    flash[:danger] = t "global.danger.not_order"
    if @order.update status: params[:order][:status]
      flash[:success] = t "global.success.update_status_order"
    else
      flash[:danger] = t "global.danger.update_status_order"
    end
    redirect_to admin_orders_path
  end
end
