class Project < ApplicationRecord
  include ImageUploader::Attachment(:landscape_image)
  include ImageUploader::Attachment(:thumbnail_image)
  has_many :counterparts, dependent: :destroy
  has_many :contributions, dependent: :destroy
  belongs_to :category
  validates :name, presence: true
  validates :goal_amount, presence: true
end
