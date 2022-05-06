class AddSubtotalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :subtotal, :decimal, default: 0
  end
end
