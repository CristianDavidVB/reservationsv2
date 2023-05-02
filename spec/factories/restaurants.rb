FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    description { Faker::Restaurant.description }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    photo { "photo.jpg" }
  end
end