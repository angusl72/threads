require "date"
require "open-uri" # for our images

puts "Cleaning users"
User.destroy_all
Item.destroy_all
Booking.destroy_all


10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.street_address
  )
  puts "creating user: #{user.id}"

  item_count = 1
  3.times do
    image_file = URI.open("https://www.legacy.com.au/wp-content/uploads/2020/10/tshirt-2.jpg")
    puts "creating item: #{item_count}"
    img_id = user.id + item_count
    item_count += 1
    item = Item.new(
      name: Faker::Coffee.variety,
      category: %w[tshirt pants top shirt jeans shoes].sample,
      description: Faker::Lorem.paragraph,
      price: [10, 15, 20, 40, 50, 70].sample,
      size: ["XS", "S", "M", "L", "XL", "XXL"].sample,
      user: user
    )
    # item.photo.attach(io: image_file, filename: "#{img_id}.jpg", content_type: "image/jpg")
    item.photo.attach(io: File.open(Rails.root.join('app/assets/images/tshirt-2.jpeg')), filename: "#{img_id}.jpg" )
    item.save!
    puts "item attached? #{item.photo.attached?}"
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
