if Rails.env.development?
  # Destroy All
  FactoryBot.create(:admin_user) unless AdminUser.any?
  p 'Admins created (or already existing)'
  FactoryBot.create_list(:user, 6) unless User.any?
  p 'Users created (or already existing)'
  # FactoryBot.create_list(:category, 1)
  p 'Categories created (or already existing)'
  FactoryBot.create_list(:project, 5) unless Project.any?
  p 'Projects created (or already existing)'
  FactoryBot.create_list(:counterpart, 10) unless Counterpart.any?
  p 'Counterparts created (or already existing)'
  FactoryBot.create_list(:contribution, 20) unless Contribution.any?
  p 'Contributions created (or already existing)'
end
