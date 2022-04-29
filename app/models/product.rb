class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :product_sku, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true

  scope :newest, ->{order created_at: :desc}
  scope :by_ids, ->(ids){where id: ids}
end
