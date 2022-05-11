module OrdersHelper
  def find_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "admin.orders.not_found"
    redirect_to root_path
  end

  def update_quantity
    if @order.pending?
      begin
        ActiveRecord::Base.transaction do
          @order.deleted!
          @order.order_details.each do |order_detail|
            stock = order_detail.product.stock
            stock += order_detail.quantity
            order_detail.product.update! stock: stock
          end
        end
      rescue ActiveRecord::RecordNotSaved
        flash[:danger] = t "global.danger.destroy_danger"
      end
      flash[:success] = t "global.success.destroy_success"
    else
      flash[:danger] = t "global.danger.pending_deleted"
    end
  end
end
