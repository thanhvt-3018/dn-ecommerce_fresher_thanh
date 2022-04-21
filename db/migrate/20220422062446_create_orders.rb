class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.boolean :status
      t.boolean :paid
      t.datetime :payment_date
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
