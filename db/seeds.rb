Product.destroy_all
Category.destroy_all
Province.destroy_all

c = Category.create(
  name:        "Card Games",
  description: "A game played with stacks of paper"
)

puts "Creating #{c.name}"

c = Category.create(
  name:        "Boardgames",
  description: "A game played with thick cardboard and plastic"
)

puts "Creating #{c.name}"

category = Category.find_by(name: "Card Games")

5.times do
  p = Product.create(
    name:        Faker::Commerce.unique.product_name,
    salePrice:   rand(999..9999).to_i,
    msrp:        rand(999..9999).to_i,
    description: Faker::Hipster.sentence(word_count: rand(4..8)),
    quantity:    rand(10..50),
    category_id: category["id"]
  )

  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
  sleep(1)
end

5.times do
  price = rand(999..9999).to_i
  p = Product.create(
    name:        Faker::Commerce.unique.product_name,
    salePrice:   price,
    msrp:        price,
    description: Faker::Hipster.sentence(word_count: rand(4..8)),
    quantity:    rand(10..50),
    category_id: category["id"]
  )

  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
  sleep(1)
end

category = Category.find_by(name: "Boardgames")

5.times do
  p = Product.create(
    name:        Faker::Commerce.unique.product_name,
    salePrice:   rand(999..9999).to_i,
    msrp:        rand(999..9999).to_i,
    description: Faker::Hipster.sentence(word_count: rand(4..8)),
    quantity:    rand(10..50),
    category_id: category["id"]
  )

  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
  sleep(1)
end

5.times do
  price = rand(999..9999).to_i
  p = Product.create(
    name:        Faker::Commerce.unique.product_name,
    salePrice:   price,
    msrp:        price,
    description: Faker::Hipster.sentence(word_count: rand(4..8)),
    quantity:    rand(10..50),
    category_id: category["id"]
  )

  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{p.name}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
  sleep(1)
end

Province.create(name: "Alberta", code: "AB", gst: 5000, pst: 0, hst: 0)
Province.create(name: "British Columbia", code: "BC", gst: 5000, pst: 7000, hst: 0)
Province.create(name: "Manitoba", code: "MB", gst: 5000, pst: 7000, hst: 0)
Province.create(name: "New Brunswick", code: "NB", gst: 0, pst: 0, hst: 15_000)
Province.create(name: "Newfoundland and Labrador", code: "NL", gst: 0, pst: 0, hst: 15_000)
Province.create(name: "Nova Scotia", code: "NS", gst: 0, pst: 0, hst: 15_000)
Province.create(name: "Ontario", code: "ON", gst: 0, pst: 0, hst: 13_000)
Province.create(name: "Prince Edward Island", code: "PE", gst: 0, pst: 0, hst: 15_000)
Province.create(name: "Quebec", code: "QC", gst: 5000, pst: 9975, hst: 0)
Province.create(name: "Saskatchewan", code: "SK", gst: 5000, pst: 6000, hst: 0)

Province.create(name: "Northwest Territories", code: "NT", gst: 5000, pst: 0, hst: 0)
Province.create(name: "Nunavut", code: "NU", gst: 5000, pst: 0, hst: 0)
Province.create(name: "Yukon", code: "YT", gst: 5000, pst: 0, hst: 0)

puts "Created #{Province.count} Provinces"

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
  password_confirmation: "password")
end
