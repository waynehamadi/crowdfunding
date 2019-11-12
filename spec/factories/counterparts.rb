# frozen_string_literal: true

FactoryBot.define do
  factory :counterpart, class: 'Counterpart' do
    name { Faker::Creature::Cat.name }
    amount_in_cents { rand(1000...5_000) }
    project
  end
end


