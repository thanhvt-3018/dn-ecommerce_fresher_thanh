class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true
end
