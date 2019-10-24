FactoryBot.define do
  factory :vehicle do
    make { "MyString" }
    model { "MyString" }
    year { 1 }
    color { "MyString" }
    license_plate { "MyString" }
    user
  end
end
