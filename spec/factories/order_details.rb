FactoryBot.define do
  factory :order_detail do
    quantity {1}
    price {100000}
    order_id {1}
    product_id {1}
  end
end
