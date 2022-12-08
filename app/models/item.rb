class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  validates :name, :category, :description, :price, :photo, presence: true 
  has_many :seller_reviews, through: :bookings
  has_many :item_reviews, through: :bookings

  validates :category, inclusion: { in: %w[T-Shirt Pants Top Shirt Jeans Shoes], message: "%{value} is not a valid clothing category" }
end
