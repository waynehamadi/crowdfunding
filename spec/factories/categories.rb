FactoryBot.define do
  factory :category, class: 'category' do
    name { Faker::Creature::Animal.name }
  end
end
