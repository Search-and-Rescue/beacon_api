class Vehicle < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
