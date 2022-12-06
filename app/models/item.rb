class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  validates :name, :category, :description, :price, :photo, presence: true
  validates :category, inclusion: { in: %w[tshirt pants top shirt jeans shoes], message: "%{value} is not a valid clothing category" }
  has_many :seller_reviews, through: :bookings
  has_many :item_reviews, through: :bookings
end
