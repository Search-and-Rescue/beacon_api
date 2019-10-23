FactoryBot.define do
  factory :trip do
    name { Faker::Company.name }
    starting_point { name }
    ending_point { Faker::Company.name }
    start_date { Faker::Date.between(from: 6.days.ago, to: Date.today) }
    start_time { start_date }
    end_date { Faker::Date.between(from: Date.today, to: 6.days.from_now) }
    end_time { end_date }
    notification_date { end_date + 1 }
    notification_time { end_time + 1  }
    traveling_companions { rand(1..2) }
    user { nil }
  end
end
