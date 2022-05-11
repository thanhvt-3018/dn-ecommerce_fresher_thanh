module Admin::Orders::OrdersHelper
  def contain_status order
    array_status = []
    t("order_status").to_a.each{|status| array_status.push(status.reverse)}
    @arr_status = array_status if order.pending?
    @arr_status = array_status.drop 1 if order.confirmed?
    @arr_status = array_status.drop 2 if order.delivering?
    @arr_status = array_status.drop 3 if order.received?
  end
end
