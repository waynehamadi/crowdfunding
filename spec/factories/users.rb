# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    password { 'password' }
    password_confirmation { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email  { "user_#{SecureRandom.hex(10)}@capsens.eu" }
    birth_date  { "12/07/1998".to_date }
  end
end
