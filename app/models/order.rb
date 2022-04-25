class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  enum status: {pending: 0, confirmed: 1, delivering: 2, received: 3,
                deleted: 4}

  scope :newest, ->{order created_at: :desc}
end
