module Types
  class TripType < Types::BaseObject
    # field :id, Integer, null: false
    field :name, String, null: false
    field :starting_point, String, null: false
    field :ending_point, String, null: false
    # field :start_date, Types::DateTimeType, null: true
    # field :start_time, Types::DateTimeType, null: true
    # field :end_date, Types::DateTimeType, null: true
    # field :end_time, Types::DateTimeType, null: true
    # field :notification_date, Types::DateTimeType, null: true
    # field :notification_time, Types::DateTimeType, null: true
    field :traveling_companions, Integer, null: true
    # field :user, Types::UserType, null: false
  end
end
