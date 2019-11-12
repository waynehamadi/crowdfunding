FactoryBot.define do
  factory :admin_user, class: 'AdminUser' do
    email { 'admin@capsens.eu' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
