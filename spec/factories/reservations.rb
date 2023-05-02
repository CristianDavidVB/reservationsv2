FactoryBot.define do
  factory  :reservation do
    number_tables { Faker::Number.between(from: 1, to: 15) }
    customer_name { Faker::Name.name }
    customer_email { Faker::Internet.email }
    date { Faker::Date.between_except(from: '2014-09-23', to: '2015-09-25', excepted: '2015-01-24') }
    restaurant
  end
end