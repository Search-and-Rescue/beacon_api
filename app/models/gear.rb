class Gear < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
