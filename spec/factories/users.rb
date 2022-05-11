FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.cell_phone}
    role {0}
    password {"password"}
    password_confirmation {"password"}
  end
end
