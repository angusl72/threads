class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :status, :start_date, :end_date, :booking_price, presence: true
  validates :status, inclusion: { in: %w[Pending Declined Completed In-progress], message: "%{value} is not a valid item type" }
end
