FactoryBot.define do
  factory :trip do
    name { "MyString" }
    starting_point { "MyString" }
    ending_point { "MyString" }
    start_date { "2019-10-20" }
    start_time { "2019-10-20 15:39:32" }
    end_date { "2019-10-20" }
    end_time { "2019-10-20 15:39:32" }
    notification_date { "2019-10-20" }
    notification_time { "2019-10-20 15:39:32" }
    traveling_companions { 1 }
    user { nil }
  end
end
