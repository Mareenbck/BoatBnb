class Boat < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :reviews, through: :reservations
  has_many_attached :photos
  geocoded_by :localisation
  after_validation :geocode, if: :will_save_change_to_localisation?
end
