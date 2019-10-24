FactoryBot.define do
  factory :emergency_contact do
    name { Faker::Name.unique.name }
    phone { Faker::PhoneNumber.unique.cell_phone }
    email { Faker::Internet.unique.email(name: name) }
    user { nil }
  end
end
