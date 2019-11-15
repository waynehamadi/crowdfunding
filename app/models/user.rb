class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, :last_name, :birthday, presence: true
  has_many :contributions, dependent: :destroy
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    user = User.new()
    user.email = auth.info.email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.birthday = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
    user.nationality = "FR"
    user.country_of_residence = "FR"
    user.provider = auth.provider
    user.uid = auth.uid
    return user
  end
end
