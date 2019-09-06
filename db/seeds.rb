# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

category_ids = Category.all.pluck(:id)

(1..100).each do |count|
  user = User.create email: Faker::Internet.safe_email, password: 'password', first_name: Faker::Name.first_name , last_name: Faker::Name.last_name 
  category_ids.sample(3).each do |category_id|
    user.user_categories.create category_id: category_id
  end
end