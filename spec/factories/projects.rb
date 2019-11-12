# frozen_string_literal: true

FactoryBot.define do
  factory :project, class: 'Project' do
    name { Faker::Company.catch_phrase }
    goal_amount { rand(10_000..50_000) }
    short_description { Faker::Lorem.paragraph(sentence_count: 1) }
    long_description { Faker::Lorem.paragraph(sentence_count: 5) }
    landscape_image { File.open(Rails.root.join('lib/sample_images/test.png')) }
    thumbnail_image { File.open(Rails.root.join('lib/sample_images/test.png')) }
    category
  end
end
