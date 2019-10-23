# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  name: "Bear Grylls",
  email: "bearg@gmail.com",
  address: "335 Cave St",
  city: "Rocky Mountain",
  state: "CO",
  zip: 80220,
  experience_level: 2
)

trip_1 = Trip.create!(
  name: "Rocky Mountain National Park Backpacking Trip",
  starting_point: "Coyote Trail Head",
  ending_point: "Coyote Trail Head",
  start_date: "May 1, 2020",
  start_time: "0800",
  end_date: "May 3, 2020",
  end_time: "2200",
  notification_date: "May 4, 2020",
  notification_time: "1500",
  traveling_companions: 0,
  user_id: user.id
)

trip_2 = Trip.create!(
  name: "Indian Peaks Backpacking Trip",
  starting_point: "Buffalo Trail Head",
  ending_point: "Wolf Trail Head",
  start_date: "June 1, 2020",
  start_time: "0800",
  end_date: "June 3, 2020",
  end_time: "2200",
  notification_date: "June 4, 2020",
  notification_time: "1500",
  traveling_companions: 0,
  user_id: user.id
)
