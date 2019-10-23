class Trip < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates_presence_of :name
end
