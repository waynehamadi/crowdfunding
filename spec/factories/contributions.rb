FactoryBot.define do
  factory :contribution, class: 'Contribution' do
    amount_in_cents { rand(1000..10_000) }
    project
    counterpart
    user
  end
end
