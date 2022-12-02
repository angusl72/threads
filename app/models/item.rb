class Item < ApplicationRecord
  belongs_to :user
  validates :name, :category, :description, :price, presence: true
  validates :category, inclusion: { in: %w(tshirt pants top shirt jeans shoes), message: "%{value} is not a valid item type" }
  has_many :bookings, dependent: :destroy
end
