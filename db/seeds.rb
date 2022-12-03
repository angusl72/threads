# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "date"

puts "Cleaning users"
User.destroy_all

20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.street_address
  )
  puts "creating user: #{user.id}"
  5.times do
    item = Item.new(
      name: Faker::Coffee.variety,
      category: %w[tshirt pants top shirt jeans shoes].sample,
      description: Faker::Lorem.paragraph,
      price: [10, 15, 20, 40, 50, 70].sample,
      size: ["XS", "S", "M", "L", "XL", "XXL"].sample,
      user: user
    )
    file = URI.open("https://www.legacy.com.au/wp-content/uploads/2020/10/tshirt-2.jpg")
    item.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
    item.save
  end
end
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
  end

puts "Finished"
