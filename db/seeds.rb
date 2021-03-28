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
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?