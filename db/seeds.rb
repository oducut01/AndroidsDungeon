Product.destroy_all
Category.destroy_all

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

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password",
#   password_confirmation: "password")
# end
