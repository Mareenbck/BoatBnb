class Review < ApplicationRecord
  belongs_to :reservation
  belongs_to :user
  validates :content, presence: true
  validates :rating,  numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
