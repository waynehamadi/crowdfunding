if Rails.env.development?
  # Destroy All
  FactoryBot.create(:admin_user) unless AdminUser.any?
  p 'Admins created (or already existing)'
  FactoryBot.create_list(:contribution, 20) unless Contribution.any?
  p 'Contributions created (or already existing)'
end
