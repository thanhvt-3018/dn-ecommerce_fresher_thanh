10.times do |n|
  product_sku = "MSP.#{n+1}"
  category_id = "1"
  name = "Product name #{n+1}"
  title = Faker::Lorem.sentence(word_count: 5)
  description = Faker::Lorem.sentence(word_count: 50)
  price = Faker::Number.decimal
  product = Product.create!(name: name, product_sku: product_sku, category_id: category_id, title: title, description: description, price: price)
  product.image.attach(io: File.open(Rails.root.join("public/images/#{n+1}.jpeg")), filename: "#{n+1}.jpeg")
end
