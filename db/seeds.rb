require "date"
require "open-uri" # for our images

puts "Cleaning users"
User.destroy_all
Item.destroy_all
Booking.destroy_all
ItemReview.destroy_all
SellerReview.destroy_all

test_user = User.create!(
  email: "test@test.com",
  password: "123456",
  first_name: "Test",
  last_name: "Account",
  address: "123 Test Street"
)

# CREATE USERS & 2 ITEMS FOR EACH USER
3.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.street_address
  )
  puts "creating user: #{user.id}"

  item_count = 1
  2.times do
    puts "creating item: #{item_count}"
    img_id = user.id + item_count
    item_count += 1
    item_category = %w[T-Shirt Pants Top Shirt Jeans Shoes].sample
    item = Item.new(
      name: "#{['Black','Red','Striped','Vintage','New','Cottagecore','Gorp','Minimalist','Tailored','Womens'].sample} #{item_category}",
      category: item_category,
      description: Faker::Lorem.paragraph,
      price: [10, 15, 20, 40, 50, 70].sample,
      size: ["XS", "S", "M", "L", "XL", "XXL"].sample,
      user: user
    )
    # Update this to select a random phto from internet
    item.photo.attach(io: File.open(Rails.root.join("app/assets/images/#{rand(1..8)}.jpg")), filename: "#{img_id}.jpg")
    item.save!
    puts "item attached? #{item.photo.attached?}"
  end
end

#ADD A BOOKING TO EACH ITEM AND REVIEWS
items = Item.all
items.each do |item|
  booking = Booking.create(
    status: %w[Pending Declined Completed In-progress].sample,
    start_date: Faker::Date.between(from: Date.today, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 10.days.from_now, to: 20.days.from_now),
    booking_price: rand(1..15),
    user: User.all.sample,
    item: item
  )
  puts "creating booking: #{booking.id}"

  10.times do
    item_review = ItemReview.create(
      booking: booking,
      rating: rand(1..5),
      feedback: Faker::Restaurant.review
    )
    puts "creating item review: #{item_review.id}"
  end
    seller_review = SellerReview.create(
        booking: booking,
        rating: rand(1..5),
        feedback: Faker::Restaurant.review
      )
    puts "creating seller review: #{seller_review.id}"
  end
puts "Finished"
