module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :starting_point, String, null: false
    field :ending_point, String, null: false
    field :start_date, String, null: true
    field :start_time, String, null: true
    field :end_date, String, null: true
    field :end_time, String, null: true
    field :notification_date, String, null: true
    field :notification_time, String, null: true
    field :traveling_companions, Integer, null: true
    field :user, Types::UserType, null: false
  end
end
