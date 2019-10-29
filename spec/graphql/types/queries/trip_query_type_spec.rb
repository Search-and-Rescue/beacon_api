require 'rails_helper'
WebMock.allow_net_connect!

RSpec.describe Types::QueryType do
  describe "trip queries" do
    it "should return all a user's trips" do
      user = create(:user)
      create_pair(:trip, user_id: user.id)
      query = (
        %(query {
          user(id: #{user.id}) {
            trips {
              name
            }
          }
        })
      )
      trips = SearchAndRescueApiSchema.execute(query).as_json['data']['user']['trips']
      expect(trips.length).to eq(2)
    end

    it "should return a single trip" do
      trip_1 = create(:trip, name: "trip_1")
      query = (
        %(query {
          trip(id: #{trip_1.id}) {
            name
          }
        })
      )
      trip = SearchAndRescueApiSchema.execute(query).as_json['data']['trip']
      expect(trip['name']).to eq(trip_1.name)
    end

    it "should return a trip that has not checked in and is past notification time" do
      user = create(:user)
      20.times do
        create(:trip)
      end
      trip = Trip.create(
        name: "Maroon Bells",
        activity_type: Faker::Job.key_skill,
        starting_point: "Maroon Bells Trailhead",
        ending_point: Faker::Company.name,
        start_date: Date.current - 1.day,
        start_time: Time.current - 12.hours,
        end_date: Date.current,
        end_time: Time.current - 6.hours,
        notification_date: Date.current,
        notification_time: Time.current - 2.hours,
        traveling_companions: rand(1..2),
        user_id: user.id,
        active: true
      )
      query = (
        %(query {
          activeTrips {
            name
            user {
              name
            }
          }
        })
      )
      results = SearchAndRescueApiSchema.execute(query).as_json['data']['activeTrips']
      expect(results.length).to eq(1)
      expect(results[0]['name']).to eq(trip.name)
      expect(results[0]['user']['name']).to eq(user.name)
    end
  end
end
