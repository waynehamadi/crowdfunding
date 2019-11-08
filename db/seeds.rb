# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  if AdminUser.find_by_email('admin1@capsens.eu')
    AdminUser.create!(email: 'admin1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  end
  if User.find_by_email('user1@capsens.eu')
    User.create!(email: 'user1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  end
end
