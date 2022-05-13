module Admin::Orders::OrdersHelper
  def contain_status order
    array_status = []
    t("order_status").to_a.each{|status| array_status.push(status.reverse)}
    return array_status if order.pending?

    return array_status.drop 1 if order.confirmed?

    return array_status.drop 2 if order.delivering?

    return array_status.drop 3 if order.received?
  end
end
