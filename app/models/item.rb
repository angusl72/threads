class Item < ApplicationRecord
  belongs_to :user
  validates :name, :type, :description, :price, presence: true
  validates :type, inclusion: { in: %w(tshirt pants top shirt jeans shoes), message: "%{value} is not a valid item type" }
end
