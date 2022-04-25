FactoryBot.define do
  factory :order do
    status {0}
    user_id {1}
    name {Faker::Name.name}
    address {Faker::Address.street_name}
    phone {Faker::PhoneNumber.cell_phone}
  end
end
