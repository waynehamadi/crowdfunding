# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  unless AdminUser.find_by_email('admin1@capsens.eu')
    AdminUser.create!(email: 'admin1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  end
  unless AdminUser.find_by_email('admin2@capsens.eu')
    AdminUser.create!(email: 'admin2@capsens.eu', password: 'password2', password_confirmation: 'password2') if Rails.env.development?
  end
  unless AdminUser.find_by_email('admin3@capsens.eu')
    AdminUser.create!(email: 'admin3@capsens.eu', password: 'password3', password_confirmation: 'password3') if Rails.env.development?
  end
  unless User.find_by_email('user1@capsens.eu')
    User.create!(first_name: "first_name1", last_name:"last_name2", birth_date:"12-01-1993", email: 'user1@capsens.eu', password: 'password1', password_confirmation: 'password1') if Rails.env.development?
  end
end
