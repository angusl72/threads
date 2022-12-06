class SellerReview < ApplicationRecord
  belongs_to :booking
  validates :feedback, :rating, presence: true
  # validates :rating, numericality: { in: 0..5, only_integer: true }
end
