class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :status, :start_date, :end_date, :booking_price, presence: true
  validates :status, inclusion: { in: %w[pending declined completed in-progress], message: "%{value} is not a valid item type" }
end
