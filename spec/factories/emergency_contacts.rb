FactoryBot.define do
  factory :emergency_contact do
    name { "MyString" }
    phone { "MyString" }
    email { "MyString" }
    user { nil }
  end
end
