FactoryBot.define do
  factory :product do
    name {Faker::Commerce.product_name}
    product_sku {Faker::Commerce.unique.promotion_code}
    title {Faker::Lorem.sentence(word_count: 5)}
    description {Faker::Lorem.sentence(word_count: 50)}
    price {Faker::Number.decimal}
    stock {100}
    category_id {1}
  end
end
