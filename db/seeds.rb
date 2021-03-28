Product.destroy_all

10.times do
  p = Product.create(
    name:        Faker::Commerce.unique.product_name,
    salePrice:   rand(999..9999).to_i,
    msrp:        rand(999..9999).to_i,
    description: Faker::Hipster.sentence(word_count: rand(4..8)),
    quantity:    rand(10..50)
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
