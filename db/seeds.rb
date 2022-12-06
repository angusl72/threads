require "date"
require "open-uri" # for our images

puts "Cleaning users"
User.destroy_all
Item.destroy_all
Booking.destroy_all
ItemReview.destroy_all
SellerReview.destroy_all

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
    item_category = %w[tshirt pants top shirt jeans shoes].sample
    item = Item.new(
      name: "#{['black','red','striped','vintage','new','cottagecore','gorp','minimalist','tailored','womens'].sample} #{item_category}",
      category: item_category,
      description: Faker::Lorem.paragraph,
      price: [10, 15, 20, 40, 50, 70].sample,
      size: ["XS", "S", "M", "L", "XL", "XXL"].sample,
      user: user
    )
    # Update this to select a random phto from internet
    item.photo.attach(io: File.open(Rails.root.join("app/assets/images/#{[1,2,3,4,5,6,7,8].sample}.jpg")), filename: "#{img_id}.jpg" )
    item.save!
    puts "item attached? #{item.photo.attached?}"
  end
end

# CREATE 1 BOOKING FOR EACH ITEM & 1 REVIEW
items = Item.all
items.each do |item|
  booking = Booking.create(
    status: %w[pending declined completed in-progress].sample,
    start_date: Faker::Date.between(from: Date.today, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 10.days.from_now, to: 20.days.from_now),
    booking_price: [10, 15, 20, 40, 50, 70].sample,
    user: User.all.sample,
    item: item
  )
  puts "creating booking: #{booking.id}"
  item_review = ItemReview.create(
    booking: booking,
    rating: rand(1..5),
    feedback: Faker::Restaurant.review
  )
  puts "creating item review: #{item_review.id}"

  seller_review = SellerReview.create(
    booking: booking,
    rating: rand(1..5),
    feedback: Faker::Restaurant.review
  )
  puts "creating seller review: #{seller_review.id}"

end

puts "Finished"
