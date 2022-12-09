class ItemReview < ApplicationRecord
  belongs_to :booking
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  has_one :item, through: :bookings
  has_one :user, through: :bookings
end
