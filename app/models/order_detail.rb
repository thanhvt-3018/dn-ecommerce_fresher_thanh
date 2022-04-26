class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: true
  validates :price, presence: true, numericality: true

  after_create :update_stock

  def update_stock
    stock = product.stock
    stock -= quantity
    product.update! stock: stock
  end
end
